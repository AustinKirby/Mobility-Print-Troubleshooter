import 'dart:ffi';

import 'package:win32/win32.dart';
import 'package:ffi/ffi.dart';

/// @nodoc
const CLSID_INetFwProducts = '{CC19079B-8272-4D73-BB70-CDB533527B61}';

/// @nodoc
const IID_INetFwProducts = '{39EB36E0-2097-40BD-8AF2-63A13B525362}';

/// {@category Interface}
/// {@category com}
class INetFwProducts extends IDispatch {
  // vtable begins at 7, is 4 entries long.
  INetFwProducts(super.ptr);

  factory INetFwProducts.from(IUnknown interface) =>
      INetFwProducts(interface.toInterface(IID_INetFwProducts));

  factory INetFwProducts.createInstance() => INetFwProducts(
      COMObject.createFromID(CLSID_INetFwProducts, IID_INetFwProducts));

  int getCount(Pointer<LONG> count) => ptr.ref.vtable
      .elementAt(7)
      .cast<
          Pointer<
              NativeFunction<Int32 Function(Pointer, Pointer<LONG> count)>>>()
      .value
      .asFunction<
          int Function(Pointer, Pointer<LONG> count)>()(ptr.ref.lpVtbl, count);

  int register(Pointer pProduct, Pointer<Pointer> ppRegistration) =>
      ptr.ref.vtable
              .elementAt(8)
              .cast<
                  Pointer<
                      NativeFunction<
                          Int32 Function(Pointer, Pointer pProduct,
                              Pointer<Pointer> ppRegistration)>>>()
              .value
              .asFunction<
                  int Function(Pointer, Pointer pProduct,
                      Pointer<Pointer> ppRegistration)>()(
          ptr.ref.lpVtbl, pProduct, ppRegistration);

  int item(int index, Pointer<Pointer<COMObject>> ppRegistration) =>
      ptr.ref.vtable
              .elementAt(9)
              .cast<
                  Pointer<
                      NativeFunction<
                          Int32 Function(Pointer, Int32 index,
                              Pointer<Pointer<COMObject>> ppRegistration)>>>()
              .value
              .asFunction<
                  int Function(Pointer, int index,
                      Pointer<Pointer<COMObject>> ppRegistration)>()(
          ptr.ref.lpVtbl, index, ppRegistration);

  int getNewEnum(Pointer<Pointer> ppNewEnum) => ptr.ref.vtable
          .elementAt(10)
          .cast<
              Pointer<
                  NativeFunction<
                      Int32 Function(Pointer, Pointer<Pointer> ppNewEnum)>>>()
          .value
          .asFunction<int Function(Pointer, Pointer<Pointer> ppNewEnum)>()(
      ptr.ref.lpVtbl, ppNewEnum);
}
