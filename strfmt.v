module strfmt

import strings

[direct_array_access]
pub fn fmt<T>(str string, args ...T) ?string {
	count := args.len
	if count == 0 || str.len == 0 {
		return str
	}

	mut builder := strings.new_builder(str.len + (args.len * 4))
	mut open := false
	mut escaped := false
	mut from := 0
	mut arg := 0
	for i, c in str {
		if c == `\\` {
			escaped = true
			continue
		}

		if c == `{` && !escaped {
			open = true
			continue
		}

		escaped = false

		if open && c == `}` {
			builder.write_string(str[from..i - 1])
			builder.write_string(args[arg].str())
			from = i + 1
			arg += 1
			open = false

			if arg == count {
				break
			}
			continue
		}

		open = false
	}

	if arg < count {
		return error('Too many arguments for string formatting')
	}

	builder.write_string(str[from..])

	out := builder.str()

	unsafe { builder.free() }
	return out
}
