# riddler_spec

The language-neutral conformance corpus for [Riddler](https://github.com/riddler):
JSON case files and JSON schemas that any implementation, in any language, can
run to prove it behaves the way the reference implementation does.

## The rule that governs this repo

**Nothing under `corpus/` or `schemas/` is edited by hand here.** Every file is
emitted from the Elixir package `riddler` in
[riddler-ex](https://github.com/riddler/riddler-ex) by:

    mix riddler.corpus --to <path to a riddler_spec checkout>

A hand edit is overwritten by the next emit, and until it is, the corpus and
the implementation it is supposed to describe disagree silently. Author the
case in riddler-ex, re-emit, open a pull request here with the emitted files.

## Layout

    corpus/<capability>/<name>.json   the case files, one per capability topic
    schemas/*.json                    the JSON schemas the documents conform to
    bin/lint                          the gate (Ruby, standard library only)
    attic/2019/                       the 2019 YAML cases, kept as the record

## The case-file shape

Every emitted file carries a `generated_by` header naming the riddler version
and the source file it came from, so a reader can always find what produced it:

    {
      "name": "...",
      "capability": "...",
      "generated_by": "riddler <version> from corpus/<capability>/<name>.exs",
      "cases": [
        {"name": "...", "input": {...}, "expected": {...}}
      ]
    }

An illustrative example - **illustrative only**, not a real case; the first
emitted corpus replaces it:

    {
      "name": "text_element",
      "capability": "element",
      "generated_by": "riddler 0.1.0 from corpus/element/text_element.exs",
      "cases": [
        {
          "name": "renders a template against the context",
          "input": {
            "element": {"id": "el_text", "type": "text", "text": "Hello {{ name }}!"},
            "context": {"name": "World"}
          },
          "expected": {
            "element": {"id": "el_text", "type": "text", "text": "Hello World!"}
          }
        }
      ]
    }

Case `name`s are unique within a file. `input` and `expected` are whatever the
capability's schema says they are; the schemas under `schemas/` are the
authority on that.

## Running a case from another language

A runner needs no Riddler-specific library. For each file under `corpus/`:

1. Read the file and parse it as JSON.
2. For each entry in `cases`, feed `input` to your implementation of the
   file's `capability`.
3. Compare the result with `expected` by value. A mismatch is a failure, and
   the file name plus the case `name` identify it.

That is the whole contract. A language that can read JSON can run the corpus.

## Adding or changing a case

1. Author or edit the case in riddler-ex's `corpus/` source.
2. Re-run `mix riddler.corpus --to <this checkout>`.
3. Open a pull request here carrying the emitted files, naming the riddler
   commit the emit ran from.

## The lint

    ruby bin/lint

Standard-library Ruby, no gems. It checks that every `corpus/**/*.json` and
`schemas/*.json` parses, that every case file carries `name`, `capability`,
`generated_by` and an array of `cases`, that case names are unique within a
file, and that every case carries `input` and `expected`. It prints the file
path and the reason and exits 1 on the first problem, and prints a count of
files and cases and exits 0 otherwise. An empty corpus is green.

## The 2019 cases

`attic/2019/` holds the YAML case files this repo carried before the corpus
was generated. They are the record of what the 2019 engine was expected to
do; their substance returns as generated JSON cases emitted from riddler-ex.
