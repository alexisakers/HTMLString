# ⚡ Benchmarks

A set of measures tracking the performance of the library.

## ⏱ Compile times

| Configuration | v2.0.1 | v2.1.0 | v2.1.1 | v2.1.2 |
|:---|---|---|---|---|
| Debug | 7.15s | 6.40s | 5,64s | 5,57s |
| Release | 32.83s | 27.21s | 23,07s | 22,86s |

## 🤖 Common Tasks

*Average time over 1000 iterations*

### Debug

| Task | v2.0.1 | v2.1.0 | v2.1.1 | v2.1.2 |
|:---|---|---|---|---|
| Unicode-escaping 2 emojis | 0.000083s | 0.000040s | 0.000006s | 0.000006s |
| ASCII-escaping 2 emojis | 0.000104s | 0.000035s | 0.000008s | 0.000007s |
| Unescaping 2 emojis | 0.000046s | 0.000049s | 0.000021s | 0.000022s |
| Unescaping a tweet | 0.000085s | 0.000033s | 0.000029s | 0.000030s |
| Unicode-escaping a tweet | 0.000844s | 0.000131s | 0.000056s | 0.000059s |
| ASCII-escaping a tweet | 0.001023s | 0.000158s | 0.000058s | 0.000061s |
| Unicode-escaping 23,145 characters | 0.159909s | 0.024684s | 0.009895s | 0.010830s |
| ASCII-escaping 23,145 characters | 0.198981s | 0.030419s | 0.010272s | 0.012069s |
| Unescaping 3,026 words with 366 escapes | 0.165962s | 0.001686s | 0.001706s | 0.001707s |

### Release

| Task | v2.0.1 | v2.1.0 | v2.1.1 | v2.1.2 |
|:---|---|---|---|---|
| Unicode-escaping 2 emojis | 0.000022s | 0.000010s | 0.000004s | 0.000005s |
| ASCII-escaping 2 emojis | 0.000033s | 0.000015s | 0.000008s | 0.000005s |
| Unescaping 2 emojis | 0.000031s | 0.000016s | 0.000012s | 0.000012s |
| Unescaping a tweet | 0.000052s | 0.000017s | 0.000023s | 0.000022s |
| Unicode-escaping a tweet | 0.000183s | 0.000064s | 0.000047s | 0.000040s |
| ASCII-escaping a tweet | 0.000276s | 0.000077s | 0.000047s | 0.000042s |
| Unicode-escaping 23,145 characters | 0.034701s | 0.011941s | 0.006806s | 0.006553s |
| ASCII-escaping 23,145 characters | 0.052937s | 0.014950s | 0.007000s | 0.006850s |
| Unescaping 3,026 words with 366 escapes | 0.014192s | 0.001162s | 0.001204s | 0.001145s |

## ❓ Estimated Asymptotic Complexity

Where `N` is the number of characters in the string.

| Algorithm | v2.0.1 | v2.1.0 | v2.1.1 | v2.1.2 |
|:---|---|---|---|---|
| ASCII escaping | N/A | N/A | O(N) | O(N) |
| Unicode escaping | N/A | N/A | O(N) | O(N) |
| Unescaping | N/A | N/A | O(N) | O(N) |