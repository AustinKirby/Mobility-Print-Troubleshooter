import 'dart:ffi';

import 'package:win32/win32.dart';
import 'package:ffi/ffi.dart';

/// @nodoc
const CLSID_INetFwProduct = '{71881699-18f4-458b-b892-3ffce5e07f75}';

/// @nodoc
const IID_INetFwProduct = '{9D745ED8-C514-4D1D-BF42-751FED2D5AC7}';

/// {@category Interface}
/// {@category com}
class INetFwProduct extends IDispatch {
  // vtable begins at 7, is 5 entries long.
  INetFwProduct(super.ptr);

  factory INetFwProduct.from(IUnknown interface) =>
      INetFwProduct(interface.toInterface(IID_INetFwProduct));

  factory INetFwProduct.createInstance() => INetFwProduct(
      COMObject.createFromID(CLSID_INetFwProduct, IID_INetFwProduct));

  int getRuleCategories(Pointer<VARIANT> pRuleCategories) =>
      ptr.ref.vtable
              .elementAt(7)
              .cast<
                  Pointer<
                      NativeFunction<
                          Int32 Function(
                              Pointer, Pointer<VARIANT> pRuleCategories)>>>()
              .value
              .asFunction<
                  int Function(Pointer, Pointer<VARIANT> pRuleCategories)>()(
          ptr.ref.lpVtbl, pRuleCategories);

  int putRuleCategories(VARIANT ruleCategories) => ptr.ref.vtable
          .elementAt(8)
          .cast<
              Pointer<
                  NativeFunction<
                      Int32 Function(Pointer, VARIANT ruleCategories)>>>()
          .value
          .asFunction<int Function(Pointer, VARIANT ruleCategories)>()(
      ptr.ref.lpVtbl, ruleCategories);

  int getDisplayName(Pointer<Utf16> pDisplayName) => ptr.ref.vtable
          .elementAt(9)
          .cast<
              Pointer<
                  NativeFunction<
                      Int32 Function(Pointer, Pointer<Utf16> pDisplayName)>>>()
          .value
          .asFunction<int Function(Pointer, Pointer<Utf16> pDisplayName)>()(
      ptr.ref.lpVtbl, pDisplayName);

  // int putDisplayName(Utf16 displayName) => ptr.ref.vtable
  //     .elementAt(10)
  //     .cast<
  //         Pointer<NativeFunction<Int32 Function(Pointer, Utf16 displayName)>>>()
  //     .value
  //     .asFunction<
  //         int Function(
  //             Pointer, Utf16 displayName)>()(ptr.ref.lpVtbl, displayName);

  int getPathToSignedProduct(Pointer<Utf16> pPath) => ptr.ref.vtable
      .elementAt(11)
      .cast<
          Pointer<
              NativeFunction<Int32 Function(Pointer, Pointer<Utf16> pPath)>>>()
      .value
      .asFunction<
          int Function(Pointer, Pointer<Utf16> pPath)>()(ptr.ref.lpVtbl, pPath);
}
