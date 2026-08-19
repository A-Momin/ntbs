## [Regular Expressions](https://en.wikipedia.org/wiki/Regular_expression)

### Metacharacters

| Metacharacter | Description                                                                                                                                                                                                                                                                                                                                                                                                          |
| ------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `^`           | Matches the starting position within the string. In line-based tools, it matches the starting position of any line.                                                                                                                                                                                                                                                                                                  |
| `$`           | Matches the ending position of the string or the position just before a string-ending newline. In line-based tools, it matches the ending position of any line.                                                                                                                                                                                                                                                      |
| `.`           | Matches any single character (many applications exclude [[newline]]s, and exactly which characters are considered newlines is flavor-, character-encoding-, and platform-specific, but it is safe to assume that the line feed character is included). Within POSIX bracket expressions, the dot character matches a literal dot. For example, `a.c` matches "abc", etc., but `[a.c]` matches only "a", ".", or "c". |
| `[]`          | A bracket expression. Matches a single character that is contained within the brackets. For example, `[abc]` matches "a", "b", or "c". `[a-z]` specifies a range which matches any lowercase letter from "a" to "z". These forms can be mixed: `[abcx-z]` matches "a", "b", "c", "x", "y", or "z", as does `[a-cx-z]`.                                                                                               |
| `[^]`         | Matches a single character that is not contained within the brackets. For example, `[^abc]` matches any character other than "a", "b", or "c". `[^a-z]` matches any single character that is not a lowercase letter from "a" to "z". Likewise, literal characters and ranges can be mixed.                                                                                                                           |
| `( )`         | Defines a marked subexpression. The string matched within the parentheses can be recalled later (see the next entry, `\''n''`). A marked subexpression is also called a block or capturing group. '''BRE mode requires `\( \)`'''.                                                                                                                                                                                   |
| `\n`          | Matches what the ''n''th marked subexpression matched, where ''n'' is a digit from 1 to 9. This construct is vaguely defined in the POSIX.2 standard. Some tools allow referencing more than nine capturing groups. Also known as a backreference. '''backreferences are only supported in BRE mode'''                                                                                                               |
| `*`           | Matches the preceding element zero or more times. For example, `ab*c` matches "ac", "abc", "abbbc", etc. `[xyz]*` matches "", "x", "y", "z", "zx", "zyx", "xyzzy", and so on. `(ab)*` matches "", "ab", "abab", "ababab", and so on.                                                                                                                                                                                 |
| `{m, n}`      | Matches repeatation of the preceding element at least ''m'' and not more than ''n'' times. For example, `a{3,5}` matches only "aaa", "aaaa", and "aaaaa". This is not found in a few older instances of regexes. '''BRE mode requires `\{m, n\}`'''.                                                                                                                                                                 |
| `?`           | Matches the preceding element zero or one time. For example, `ab?c` matches only "ac" or "abc".                                                                                                                                                                                                                                                                                                                      |
| `+`           | Matches the preceding element one or more times. For example, `ab+c` matches "abc", "abbc", "abbbc", and so on, but not "ac".                                                                                                                                                                                                                                                                                        |
| `\|`          | The choice (also known as alternation or set union) operator matches either the expression before or the expression after the operator. For example, `abc \| def` matches "abc" or "def".                                                                                                                                                                                                                            |

#### Examples

-   `.at`
    -   matches any three-character string ending with "at", including "hat", "cat", and "bat".
-   `[hc]at`
    -   matches "hat" and "cat".
-   `[^b]at`
    -   matches all strings matched by `.at` except "bat".
-   `[^hc]at`
    -   matches all strings matched by `.at` other than "hat" and "cat".
-   `^[hc]at`
    -   matches "hat" and "cat", but only at the beginning of the string or line.
-   `[hc]at$`
    -   matches "hat" and "cat", but only at the end of the string or line.
-   `\[.\]`
    -   matches any single character surrounded by "[" and "]" since the brackets are escaped, for example: "[a]" and "[b]".
-   `s.*`

    -   matches s followed by zero or more characters, for example: "s" and "saw" and "seed".

-   `[hc]?at`
    -   matches "at", "hat", and "cat".
-   `[hc]*at`
    -   matches "at", "hat", "cat", "hhat", "chat", "hcat", "cchchat", and so on.
-   `[hc]+at`
    -   matches "hat", "cat", "hhat", "chat", "hcat", "cchchat", and so on, but not "at".
-   `cat|dog`
    -   matches "cat" or "dog".
-   `^[\.-)( ]*([0-9]{3})[\.-)( ]*([0-9]{3})[\.-)( ]*([0-9]{4})$`

    -   The first part `^` means the "start of the line" which will force it to account for the whole string.
    -   The `[\.-)( ]*` that I have in there mean "any period, hyphen, parenthesis, or space appearing 0 or more times".
    -   The `([0-9]{3})` clusters match a group of 3 numbers (the last one is set to match 4)

-   `^((?!hede).)*$`
    The regex above will match any string, or line without a line break, not containing the (sub)string 'hede'.

| Special Sequences | Meaning                              |
| ----------------- | ------------------------------------ |
| `.`               | Any Character Except New Line        |
| `\d`              | Digit `(0-9)`                        |
| `\D`              | Not a Digit `(0-9)`                  |
| `\w`              | Word Character `(a-z, A-Z, 0-9, _)`  |
| `\W`              | Not a Word Character                 |
| `\s`              | Whitespace (space, tab, newline)     |
| `\S`              | Not Whitespace (space, tab, newline) |

| Anchore | Meaning               |
| ------- | --------------------- |
| `\b`    | Word Boundary         |
| `\B`    | Not a Word Boundary   |
| `^`     | Beginning of a String |
| `$`     | End of a String       |

| Characterset | Meaning                            |
| ------------ | ---------------------------------- |
| `[]`         | Matches Characters in brackets     |
| `[^ ]`       | Matches Characters NOT in brackets |
| `\|`         | Either Or `\|`                     |
| `( )`        | Group                              |

| Quantifiers | Meaning                       |
| ----------- | ----------------------------- |
| `*`         | 0 or More                     |
| `+`         | 1 or More                     |
| `?`         | 0 or One                      |
| `{3}`       | Exact Number                  |
| `{3,4}`     | Range of Numbers `(Min, Max)` |
