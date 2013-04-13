# LibIME

オブジェクトに大してIME入力中かどうかを判定するjsライブラリです。

jQueryがあると、jQueryのメソッドを使います。

# 使い方

同梱のsample.htmlをご覧ください。

```javascript
var ime = new LibIME('#text');
ime.onkeyup = function (event) {
  console.log(ime.status);
}
```

## `ime.onkeydown`, `ime.onkeypress`, `ime.onkeydown`
イベント発生時に実行する関数をいれます。

## `ime.status`
現在のステータスが入ります。

* `2`: 直接入力中
* `1`: IME確定
* `0`: IME入力中

## `ime.parse`
statusを日本語にパースします、ロガーにご利用ください

