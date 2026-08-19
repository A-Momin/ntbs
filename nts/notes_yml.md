### Table of Content:

-   Terms and Concepts
-   Folding and chomping
-   Nested sequences
-   Nested mappings
-   Combining sequences and mappings Dates in markdown files
-   Repeated nodes Adding data types

---

<details><summary style="font-size:25px;color:Orange;text-align:left">Terms & Concepts</summary>

-   `YAML`: YAML is a human-readable data serialization language that is often used for configuration files and data exchange between languages.
-   `Indentation`: YAML uses indentation to represent the structure of data. Indentation is used to define nested elements, such as lists and dictionaries.
-   `Scalar`: A scalar is a single value in YAML, such as a string, number, or boolean.
-   `Mapping`: A mapping is a collection of key-value pairs in YAML, also known as a dictionary or hash.
-   `Sequence`: A sequence is an ordered list of values in YAML, also known as a list or array.
-   `Anchors`: Anchors are used to mark a specific node in a YAML document. Anchors can be referenced later in the document, allowing for more efficient use of memory.
-   `Aliases`: Aliases are used to reference an anchor in a YAML document.
-   `Comments`: Comments can be added to a YAML document using the '#' character. Comments are ignored by parsers and can be used to add notes or documentation to the document.
-   `Tags`: Tags are used to specify the data type of a value in a YAML document. For example, the tag '!int' can be used to indicate that a value is an integer.
-   `Flow style`: Flow style is a compact way of representing data in YAML. Flow style uses brackets and commas to represent lists and dictionaries, and can be more difficult to read than block style.

#### Node:

-   A "node" refers to a basic unit of data within a YAML document. Nodes represent values or data structures that can be `scalar`, `mapping`, or `sequence` types.
-   Nodes are the basic building blocks of a YAML document and can be nested to create more complex data structures. Each node in a YAML document is identified by its position within the document, which is determined by its level of indentation relative to other nodes.
-   Nodes can also be tagged with a data type using a tag or a built-in YAML tag. This helps ensure that the data is correctly interpreted when read by different programming languages or applications.

-   Three types of Nodes:

    1. `Scalar Node`: A scalar node represents a single value, such as a string, integer, float, boolean, or null. Scalar nodes do not have any internal structure or sub-elements.

    ```yml
    key: value
    number: 42
    is_active: true
    ```

    2. `Mapping Node`: A mapping node represents a collection of key-value pairs, similar to a dictionary or object in other programming languages. It is denoted by indentation using spaces or tabs and uses a colon (:) to separate keys and values. The keys must be unique within a mapping.

    ```yml
    person:
        name: John Doe
        age: 30
        city: London
    ```

    3. `Sequence Node`: A sequence node represents an ordered collection of items, similar to a list or array. It is denoted by a hyphen (-) followed by the value or item. Sequence nodes can contain scalar values, mapping nodes, or other sequence nodes.

    ```yml
    fruits:
        - apple
        - banana
        - mango
    ```

```yaml
languages: # (a mapping node, which contains a sequence node)
    - programming: # (a sequence node, which contains two mapping nodes)
          - frontend: # (a sequence node, which contains three scalar nodes)
                - html
                - css
                - js
          - backend: # (a sequence node, which contains three scalar nodes)
                - java
                - python
                - c#
    - data serialization: # (a sequence node, which contains two scalar nodes)
          - yaml
          - json
```

#### Document:

In YAML, a "document" refers to a complete, self-contained block of YAML data that can be parsed and processed as a single entity. A document can contain one or more YAML nodes, which are the individual elements of data within the document.

A YAML document is typically defined by starting with a line that contains three dashes ---, which indicates the beginning of a new document. The end of a document is indicated by a line that contains three dots ....

Multiple documents can be included in a single YAML file, each separated by the three-dash delimiter. In this case, each document can have its own set of nodes and can be parsed and processed separately from the other documents in the file.

---

-   One file can contain multiple documents
-   Documents are separated by 3 hyphens (---)
-   Can be ended with suffix of 3 dots (...)

---

The following YAML file contains two documents, each with a single node:

```yaml
---
name: John Doe
age: 30
hobbies:
    - reading
    - hiking
    - cooking
---
title: My Blog Post
author: Jane Smith
date: 2023-02-20
content: |
    This is my first blog post. Thanks for reading!
```

In this example, the first document has a mapping node with three scalar nodes and one sequence node, while the second document has a mapping node with three scalar nodes and a multi-line scalar node for the "content" field.

</details>

---

### Table

| EC2 vs EMR                | **AWS EMR**                           | **AWS EC2**                      |
| :------------------------ | :------------------------------------ | :------------------------------- |
| **Distributed computing** | Yes                                   | Yes                              |
| **Node categorization**   | Categorizes secondary nodes into core | Does not use node categorization |

### Folding and Chomping:

`Folding` and `Chomping` are techniques used to control how line breaks and whitespace are handled within scalar values. They help to format and represent text in a desired manner. Let's explore each technique.

#### Folding:

there are different types of folding styles that can be used to control how multiline text is represented. These folding styles determine how line breaks and indentation are handled. Let's explore the three folding styles in YAML:

-   `LITERAL FOLDING` (`|`):

    -   Literal folding uses the `|` character to indicate that the following text should be rendered as-is, with any line breaks preserved.

    ```yml
    description: |
        This is a long description
        that spans multiple lines
        with preserved line breaks
        and indentation.
    ```

-   `BLOCK FOLDING` (`>`):

    -   Block folding uses the `>` character to indicate that the following text should be folded over multiple lines. Any line breaks in the text will be replaced with spaces.

    ```yml
    description: >
        This is a long string of text that is folded over multiple lines.
        It is easier to read and understand this way.
    ```

-   `FLOW FOLDING` (`|+`):

    -   Flow folding uses the `|+` character to indicate that the following text should be folded over multiple lines, but with each line indented by at least one space. This can be useful for making long strings easier to read.

    ```yml
    description: |+
        This is a long description that spans multiple lines without line breaks and indentation.
    ```

#### Chomping:

Chomping controls how trailing and leading whitespace in a scalar value is treated.

-   There are three chomping indicators:

    -   `+` (`Strip`): Trailing whitespace is removed, but a single final line break is preserved.
    -   `-` (`Clip`): Trailing whitespace and the final line break are removed.
    -   `~` (`Keep`): Trailing whitespace is preserved, including the final line break.

-   Chomping indicators can be combined with the folding indicator (>) to achieve the desired behavior.

```yaml
multi-line: |+
    Some silly text across multiple lines,very important to include some white spaceAnd some    more indentationAnd some trailing newlines.
```

### Nested Sequences

```yaml
flow_list:
    - [of, lists]
    - [and, lists]

block_list:
    - - of
      - lists
    - - and
      - lists
```

```yaml
- [programming, coding, scripting]
- [data serialization, serializing]
```

Alternatively,

```yaml
- - programming
  - coding
  - scripting
- - data serialization
  - serializing
```

### YAML Nested Mappings

```yaml
person:
    name: Maaike
    age: 30
    address:
        streetname: Langstraat
        number: 1
        zipcode: 1234AB
        country: The Netherlands
    flow-mapping: { where: inside, what: mapping }
```

### Combining Sequences and Mappings

-   Map scalar to sequence
-   Sequence of mappings
-   Mapping of sequence of mappings

```yaml
languages:
    - programming:
          - frontend:
                - html
                - css
                - js
          - backend:
                - java
                - python
                - c#
    - data serialization:
          - yaml
          - json

languages:
    - programming: [frontend: [html, css, js], backend: [java, python, c#]]
    - data serialization: [yaml, json]
```

### YAML Dates

```yaml
timestamp: 2022-03-22T22:19:56.10+02:00
simple-date: 2022-03-22
```

### Repeated Nodes:

-   You define a block using an anchor (`&anchor_name`), and then refer to it using an alias (`*anchor_name`).
-   Anchors are denoted using a `&` character followed by the anchor name. We specify an alias using the `*` character followed by the anchor name
-   Anchor person (`&person`) and next referenced with alias (`*person`)
-   Overwrite part of the repeated node with merge key `<<`:

```yaml
person: &person
    name: Maaike
    age: 30
    address:
        streetname: Langstraat
        number: 1
        zipcode: 1234AB
        country: The Netherlands
another_person: *person

yet_another_person:
    <<: *person
    name: maria
```

### YAML Working with Tags

-   Tags give a node a type
-   Untagged nodes are given a type
-   Explicit typing can be done with the `!`
-   Schemas specify the tags

```yaml
not-a-date: !!str 2022-03-21
not-a-number: !!str 20
unnecessary: !!int 20
```

### Working with Schemas

-   Default: Failsafe schema, JSON schema and core schema
-   Used to create custom data types with language specific schemas
-   Programming languages have their own schema that map YAML to the language native data structure
-   Interoperable schemas use global tags to represent the same data across different languages

#### Failsafe Schema

-   Three tags: string, mapping, sequence

```yaml
!!str: a string value !
!map: a mapping
!!seq: a sequence
! Is shorthand for !<tag:yaml.org,2002:...>
```

#### JSON Schema

-   Failsafe tags

```yaml
!!null: a null value
!!bool: boolean
!!int: integer
!!float: float
```
