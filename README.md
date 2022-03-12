Tiny, fast, string formatting in V.

```v
import strfmt { fmt }

fn main() {
  a := 3
  b := 4
  println(fmt("{}+{}={}", a, b, a+b) ?)
  println(fmt("Hello {}!", "World") ?)
}
```

```
3+4=7
Hello World!
```
