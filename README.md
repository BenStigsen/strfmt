Tiny, fast, string formatting in V.

```v
import strformat { format }

fn main() {
  a := 3
  b := 4
  println(format("{}+{}={}", a, b, a+b) ?)
  
  println(format("Hello {}!", "World") ?)
}
```

```
3+4=7
Hello World!
```
