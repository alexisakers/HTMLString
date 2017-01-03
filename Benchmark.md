# ⚡ Benchmarks

A set of measures tracking the performance of the library.

## ⏱ Compile times

| Configuration | v2.0.1 | v2.1.0 |
|:---|---|---|
| Debug | 7,83s | 12.892s |
| Release | 6,59s | 30.605s |

## 🤖 Common Tasks

### Debug

| Task | v2.0.1 | v2.1.0 |
|:---|---|---|
| Unicode-escaping 2 emojis | 0.000083s | 0.000018s |
| ASCII-escaping 2 emojis | 0.000104s | 0.000032s |
| Unescaping 2 emojis | 0.000046s | 0.000052s |
| Unescaping a tweet | 0.000085s | 0.000032s |
| Unicode-escaping a tweet | 0.000844s | 0.000138s |
| ASCII-escaping a tweet | 0.001023s | 0.000170s |
| Unicode-escaping 23,145 characters | 0.159909s | 0.024200s |
| ASCII-escaping 23,145 characters | 0.198981s | 0.028385s |
| Unescaping 3,026 words with 366 escapes | 0.165962s | 0.001753s |

### Release

| Task | v2.0.1 | v2.1.0 |
|:---|---|---|
| Unicode-escaping 2 emojis | 0.000022s | 0.000010s |
| ASCII-escaping 2 emojis | 0.000033s | 0.000018s |
| Unescaping 2 emojis | 0.000031s | 0.000018s |
| Unescaping a tweet | 0.000052s | 0.000020s |
| Unicode-escaping a tweet | 0.000183s | 0.000077s |
| ASCII-escaping a tweet | 0.000276s | 0.000088s |
| Unicode-escaping 23,145 characters | 0.034701s | 0.011898s |
| ASCII-escaping 23,145 characters | 0.052937s | 0.014194s |
| Unescaping 3,026 words with 366 escapes | 0.014192s | 0.001135s |

## ❓ Complexity

TODO

| Algorithm | v2.0.1 | v2.1.0 |
|:---|---|---|
| ASCII escaping | N/A | N/A |
| Unicode escaping | N/A | N/A |
| Unescaping | N/A | N/A |