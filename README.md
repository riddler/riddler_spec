# Riddler Spec

These are shared test cases of how the Riddler engine shold work.

Example: the following yaml (found in `content_definitions/element_basic.yml`)

```yaml
---
name: basic_text_element
definition:
  id: el_text
  name: text
  content_type: element
  type: text
  text: "Hello {{ params.name }}!"

tests:
- name: with_no_context
  result:
    content_type: element
    type: text
    id: el_text
    name: text
    text: Hello !

- name: with_name_param
  context:
    params:
      name: World
  result:
    content_type: element
    type: text
    id: el_text
    name: text
    text: Hello World!
```

With this example, we have one `definition` and two tests for it.

The first requires the result to be a hash, and the `text` field to be `Hello !`.

The second test adds a context with `params.name = "World"` and the field `text`
should be `Hello World!`
