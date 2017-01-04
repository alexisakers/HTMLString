# ⚡ Benchmarks

A set of measures tracking the performance of the library.

## ⏱ Compile times

| Configuration | v2.0.1 | v2.1.0 |
|:---|---|---|
| Debug | 7.15s | 6.40s |
| Release | 32.83s | 27.21ss |

## 🤖 Common Tasks

### Debug

| Task | v2.0.1 | v2.1.0 |
|:---|---|---|
| Unicode-escaping 2 emojis | 0.000083s | 0.000040s |
| ASCII-escaping 2 emojis | 0.000104s | 0.000035s |
| Unescaping 2 emojis | 0.000046s | 0.000049s |
| Unescaping a tweet | 0.000085s | 0.000033s |
| Unicode-escaping a tweet | 0.000844s | 0.000131s |
| ASCII-escaping a tweet | 0.001023s | 0.000158s |
| Unicode-escaping 23,145 characters | 0.159909s | 0.024684s |
| ASCII-escaping 23,145 characters | 0.198981s | 0.030419s |
| Unescaping 3,026 words with 366 escapes | 0.165962s | 0.001686s |

### Release

| Task | v2.0.1 | v2.1.0 |
|:---|---|---|
| Unicode-escaping 2 emojis | 0.000022s | 0.000010s |
| ASCII-escaping 2 emojis | 0.000033s | 0.000015s |
| Unescaping 2 emojis | 0.000031s | 0.000016s |
| Unescaping a tweet | 0.000052s | 0.000017s |
| Unicode-escaping a tweet | 0.000183s | 0.000064s |
| ASCII-escaping a tweet | 0.000276s | 0.000077s |
| Unicode-escaping 23,145 characters | 0.034701s | 0.011941s |
| ASCII-escaping 23,145 characters | 0.052937s | 0.014950s |
| Unescaping 3,026 words with 366 escapes | 0.014192s | 0.001162s |

## ❓ Complexity

TODO

| Algorithm | v2.0.1 | v2.1.0 |
|:---|---|---|
| ASCII escaping | N/A | N/A |
| Unicode escaping | N/A | N/A |
| Unescaping | N/A | N/A |