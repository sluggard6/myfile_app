main() {
  String? s;
  print("a${s != null ? s : ""}");

  // _test(true);
  // _test(false);
  A a = A();
  print(a.value);
  a.value = "abc";
  // a.value('bcd');
  print(a.value);
  a.value = null;
  print(a.value);
}

_test(bool b) {
  if (b) {
    print('true');
  } else {
    print('false');
  }
  print(b);
}

class A {
  String? _value;
  String get value => _value ?? 'null';
  set value(String? _value) => this._value = _value;
  bool isNull() => _value == null;
}
