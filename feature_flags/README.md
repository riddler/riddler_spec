# Feature Flags

These define how the top level `Riddler.feature_flags(definition, context)` should operate.

The feature flag must be added to the context under the `self` key before evaluating conditions.

Example: the following yaml (found in `feature_flags/toggles.yml`)

```yaml
---
name: toggles
definition:
  feature_flags:
  - id: ff_toggle_enabled
    type: Toggle
    name: ops_good_vendor
    enabled: true

  - id: ff_toggle_disabled
    type: Toggle
    name: ops_iffy_vendor
    enabled: false

  - id: ff_toggle_hidden
    type: Toggle
    name: ops_bad_vendor
    enabled: false
    include_condition: feature.enabled
    include_condition_instructions: [["load", "feature.enabled"], ["to_bool"]]

  - id: ff_toggle_override
    type: Toggle
    name: ops_qa
    enabled: false
    override_condition: params.ops_qa is present
    override_condition_instructions: [["load", "params.ops_qa"], ["present"]]

tests:
- name: with_no_context
  result:
    ops_good_vendor: true
    ops_iffy_vendor: false
    ops_qa: false

- name: with_ops_qa_override
  context:
    params:
      ops_qa: 1
  result:
    ops_good_vendor: true
    ops_iffy_vendor: false
    ops_qa: true
```

The result of calling `Riddler.feature_flags(definition, context)` is a map of
`feature_flag_name`s holding the value of each feature for that context.