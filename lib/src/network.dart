import 'dart:developer';
import 'dart:ffi';

import 'package:network_info_plus/network_info_plus.dart';
import 'package:printer_fleet_troubleshoot/src/troubleshoot.dart';
import 'package:win32/win32.dart';
import 'package:ffi/ffi.dart';

class Network implements Troubleshoot {
  bool _isConnected = false;
  String _connectedNetworkName = "";

  bool _getIsNetworkConnected() {
    bool networkConnected = false;

    var hr = CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);
    if (FAILED(hr)) {
      return networkConnected;
    }

    final netManager = NetworkListManager.createInstance();
    final nlmConnectivity = calloc<Int32>();

    try {
      hr = netManager.getConnectivity(nlmConnectivity);
      if (FAILED(hr)) {
        throw WindowsException(hr);
      }

      final connectivity = nlmConnectivity.value;

      if (connectivity & NLM_CONNECTIVITY.NLM_CONNECTIVITY_IPV4_INTERNET ==
          NLM_CONNECTIVITY.NLM_CONNECTIVITY_IPV4_INTERNET) {
        networkConnected = true;
      }

      if (connectivity & NLM_CONNECTIVITY.NLM_CONNECTIVITY_IPV6_INTERNET ==
          NLM_CONNECTIVITY.NLM_CONNECTIVITY_IPV6_INTERNET) {
        networkConnected = true;
      }
    } finally {
      free(nlmConnectivity);
      free(netManager.ptr);
      CoUninitialize();
    }

    return networkConnected;
  }

  Future<String> _getNetworkName() async {
    NetworkInfo info = NetworkInfo();
    return (await info.getWifiName()).toString();
  }

  _parseNetworkInformation() async {
    _isConnected = _getIsNetworkConnected();
    _connectedNetworkName = await _getNetworkName();
  }

  bool isConnected() => _isConnected;
  String connectedNetworkName() => _connectedNetworkName;
  bool isNetworkName(String name) => connectedNetworkName() == name;

  @override
  Future<TroubleshootResult> troubleshoot() async {
    await _parseNetworkInformation();

    await Future.delayed(const Duration(seconds: 1));

    if (!isConnected()) {
      return TroubleshootResult(
        message: "There is no network connection.",
        state: TroubleshootState.fail,
      );
    }

    if (!isNetworkName("ACSecure")) {
      return TroubleshootResult(
        message: "Connected network is not ACSecure.",
        state: TroubleshootState.fail,
      );
    }

    return TroubleshootResult(
      message: "Connected network is ACSecure.",
      state: TroubleshootState.success,
    );
  }
}
