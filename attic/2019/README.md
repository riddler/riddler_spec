# The 2019 YAML cases

These four files are the shared test cases this repository carried in 2019,
before the corpus was generated. Each one pairs a single `definition` with a
list of `tests`, and each test names an optional `context` and the `result`
the engine was expected to produce for that definition under it. They are kept
here unchanged as the record of what the 2019 engine was expected to do, and
`git log --follow` still reaches their original history. They are not run by
`bin/lint` and nothing consumes them: their substance returns as generated
JSON cases emitted into `corpus/` from riddler-ex.
