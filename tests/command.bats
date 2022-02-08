#!/usr/bin/env bats

load "$BATS_PATH/load.bash"

# Uncomment to enable stub debug output:
export OCTO_STUB_DEBUG=/dev/tty

@test "Run runbook command" {
    export BUILDKITE_PLUGIN_RUN_RUNBOOK_ENVIRONMENTS="Test"
    export BUILDKITE_PLUGIN_RUN_RUNBOOK_PROJECT="Test project"
    export BUILDKITE_PLUGIN_RUN_RUNBOOK_RUNBOOK="Test runbook"

    stub octo "run-runbook --environment Test --project Test project --runbook Test runbook : echo octo command ran"

    run $PWD/hooks/command

    assert_output --partial "octo command ran"
    assert_success

    unstub octo
    unset BUILDKITE_PLUGIN_RUN_RUNBOOK_ENVIRONMENTS
    unset BUILDKITE_PLUGIN_RUN_RUNBOOK_PROJECT
    unset BUILDKITE_PLUGIN_RUN_RUNBOOK_RUNBOOK
}