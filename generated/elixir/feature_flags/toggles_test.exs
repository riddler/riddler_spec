# AUTOGENERATED FILE - DO NOT EDIT
defmodule Riddler.TogglesTest do
  use ExUnit.Case, async: false
  @moduletag :spec

  setup_all do
    %{definition: %{:feature_flags: [%{"id": "ff_toggle_enabled", "type": "Toggle", "name": "ops_good_vendor", "enabled": true}, %{"id": "ff_toggle_disabled", "type": "Toggle", "name": "ops_iffy_vendor", "enabled": false}, %{"id": "ff_toggle_hidden", "type": "Toggle", "name": "ops_bad_vendor", "enabled": false, "include_condition": "feature.enabled", "include_condition_instructions": [["load", "feature.enabled"], ["to_bool"]]}, %{"id": "ff_toggle_override", "type": "Toggle", "name": "ops_qa", "enabled": false, "override_condition": "params.ops_qa is present", "override_condition_instructions": [["load", "params.ops_qa"], ["present"]]}]}}
  end

  test "with_no_context", context do
    riddler_context = nil
    expected_result = {"ops_good_vendor"=>true, "ops_iffy_vendor"=>false, "ops_qa"=>false}

    result = Riddler.render context[:definition], riddler_context
    assert expected_result == result
  end

  test "with_ops_qa_override", context do
    riddler_context = %{:params: %{:ops_qa: 1}}
    expected_result = {"ops_good_vendor"=>true, "ops_iffy_vendor"=>false, "ops_qa"=>true}

    result = Riddler.render context[:definition], riddler_context
    assert expected_result == result
  end

end