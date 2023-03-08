import 'dart:developer';
import 'dart:ffi';

import 'package:printer_fleet_troubleshoot/src/net32/inetfwproduct.dart';
import 'package:printer_fleet_troubleshoot/src/net32/inetfwproducts.dart';
import 'package:printer_fleet_troubleshoot/src/troubleshoot.dart';
import 'package:win32/win32.dart';

import 'package:ffi/ffi.dart';

class Firewall implements Troubleshoot {
  bool hasThirdPartyFirewall = false;

  int _getThirdPartyFirewallCount() {
    var hr = CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);
    if (FAILED(hr)) {
      throw WindowsException(hr);
    }

    final iNetFwProducts = INetFwProducts.createInstance();
    final pCount = calloc<LONG>();

    try {
      hr = iNetFwProducts.getCount(pCount);
      if (FAILED(hr)) throw WindowsException(hr);
    } catch (e) {
      log(e.toString());
    } finally {
      free(pCount);
      iNetFwProducts.release();
      CoUninitialize();
    }

    return pCount.value;
  }

  String _getThirdPartyFirewallName(int count) {
    String name = "";
    var hr = CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);
    if (FAILED(hr)) {
      throw WindowsException(hr);
    }

    final iNetFwProducts = INetFwProducts.createInstance();
    var ppRegistration = calloc<Pointer<COMObject>>();
    var ppDisplayName = calloc<Pointer<Utf16>>();
    var pDisplayName = ppDisplayName.value;

    try {
      for (int i = 0; i < count; i++) {
        hr = iNetFwProducts.item(i, ppRegistration);
        if (FAILED(hr)) {
          throw WindowsException(hr);
        }
        var iNetFwProduct = INetFwProduct(ppRegistration.value);
        // log(ppRegistration.value.ref.toString());
        // log(iNetFwProduct.ptr.ref.vtable.elementAt(9).toString());
        // hr = iNetFwProduct.ptr.ref.vtable
        //         .cast<
        //             Pointer<
        //                 NativeFunction<
        //                     Int32 Function(
        //                         Pointer, Pointer<Utf16> pDisplayName)>>>()
        //         .value
        //         .asFunction<
        //             int Function(Pointer, Pointer<Utf16> pDisplayName)>()(
        //     iNetFwProduct.ptr.ref.lpVtbl, pDisplayName);
        // hr = iNetFwProduct.getDisplayName(pDisplayName);
        // if (FAILED(hr)) {
        //   throw WindowsException(hr);
        // }
        // if (SUCCEEDED(hr)) {
        //   log(pDisplayName.value.toDartString());
        // }
      }
    } catch (e) {
      log(e.toString());
    } finally {
      free(pDisplayName);
      free(ppDisplayName);
      free(ppRegistration);
      iNetFwProducts.release();
      CoUninitialize();
    }

    return name;
  }

  _parseFirewall() {
    int count = _getThirdPartyFirewallCount();
    hasThirdPartyFirewall = count != 0;
    // if (count > 0) {
    //   _getThirdPartyFirewallName(count);
    // }
  }

  @override
  Future<TroubleshootResult> troubleshoot() async {
    _parseFirewall();

    await Future.delayed(const Duration(seconds: 1));

    if (hasThirdPartyFirewall) {
      return TroubleshootResult(
        message: "Detected a third party firewall.",
        state: TroubleshootState.fail,
      );
    }

    return TroubleshootResult(
      message: "There does not appear to be a third party firewall.",
      state: TroubleshootState.success,
    );
  }
}
