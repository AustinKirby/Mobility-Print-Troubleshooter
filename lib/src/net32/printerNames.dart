import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';
import 'package:win32/winrt.dart';

class PrinterNames {
  final int _flags;

  PrinterNames(this._flags);

  Iterable<String> all() sync* {
    try {
      _getBufferSize();

      try {
        _readRawBuffer();
        yield* parse();
      } finally {
        free(_rawBuffer);
      }
    } finally {
      free(_pBufferSize);
      free(_bPrinterLen);
    }
  }

  late Pointer<DWORD> _pBufferSize;
  late Pointer<DWORD> _bPrinterLen;

  void _getBufferSize() {
    _pBufferSize = calloc<DWORD>();
    _bPrinterLen = calloc<DWORD>();

    EnumPrinters(_flags, nullptr, 2, nullptr, 0, _pBufferSize, _bPrinterLen);

    if (_pBufferSize.value == 0) {
      throw 'Read printer buffer size fail';
    }
  }

  late Pointer<BYTE> _rawBuffer;

  void _readRawBuffer() {
    _rawBuffer = malloc.allocate<BYTE>(_pBufferSize.value);

    final isRawBuffFail = EnumPrinters(_flags, nullptr, 2, _rawBuffer,
            _pBufferSize.value, _pBufferSize, _bPrinterLen) ==
        0;

    if (isRawBuffFail) {
      throw 'Read printer raw buffer fail';
    }
  }

  Iterable<String> parse() sync* {
    for (var i = 0; i < _bPrinterLen.value; i++) {
      final printer = _rawBuffer.cast<PRINTER_INFO_2>().elementAt(i);
      yield printer.ref.pPrinterName.toDartString();
    }
  }
}
