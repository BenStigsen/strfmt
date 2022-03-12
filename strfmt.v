module strfmt

import strings

pub fn format<T>(str string, args ...T) ?string {
  if args.len == 0 || str.len == 0 {
    return str
  }

  mut positions := []int{cap: str.len / 5}
  mut open := false
  mut escaped := false
  for i, c in str {
    if c == `\\` {
      escaped = true
      continue
    }
    
    if c == `{` && !escaped {
      open = true
      continue
    } else {
      escaped = false
    }
    
    if open {
      if c == `}` {
        positions << i-1
      }
      open = false
    } else {
      escaped = false
      open = false
    }
  }
  
  mut builder := strings.new_builder(str.len + (args.len * 4))
  mut from := 0
  if positions.len >= args.len {
    for i, value in args {
      pos := positions[i]
      builder.write_string(str[from..pos])
      builder.write_string(value.str())
      from = pos+2
    }
  } else {
    return error("Format string has more formatters than arguments")
  }
  
  builder.write_string(str[from..])
  return builder.str()
}
