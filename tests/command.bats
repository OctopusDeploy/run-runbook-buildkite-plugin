#!/usr/bin/env bats

load "$BATS_PATH/load.bash"

# Uncomment to enable stub debug output:
export OCTO_STUB_DEBUG=/dev/tty

@test "Run runbook command" {
    export BUILDKITE_PLUGIN_RUN_RUNBOOK_ENVIRONMENTS="Test"
    export BUILDKITE_PLUGIN_RUN_RUNBOOK_PROJECT="Test project"
    export BUILDKITE_PLUGIN_RUN_RUNBOOK_RUNBOOK="Test runbook"

    stub octo 'run-runbook --environment \"Test\" --project \"Test project\" --runbook \"Test runbook\" : echo octo command ran'

    run $PWD/hooks/command

    assert_output --partial "octo command ran"
    assert_success

    unstub octo
    unset BUILDKITE_PLUGIN_RUN_RUNBOOK_ENVIRONMENTS
    unset BUILDKITE_PLUGIN_RUN_RUNBOOK_PROJECT
    unset BUILDKITE_PLUGIN_RUN_RUNBOOK_RUNBOOK
}

@test "Run runbook command with snapshot" {
    export BUILDKITE_PLUGIN_RUN_RUNBOOK_ENVIRONMENTS="Test"
    export BUILDKITE_PLUGIN_RUN_RUNBOOK_PROJECT="Test project"
    export BUILDKITE_PLUGIN_RUN_RUNBOOK_RUNBOOK="Test runbook"
    export BUILDKITE_PLUGIN_RUN_RUNBOOK_SNAPSHOT="1337"

    stub octo 'run-runbook --environment \"Test\" --project \"Test project\" --runbook \"Test runbook\" --snapshot \"1337\" : echo octo command ran'

    run $PWD/hooks/command

    assert_output --partial "octo command ran"
    assert_success

    unstub octo
    unset BUILDKITE_PLUGIN_RUN_RUNBOOK_ENVIRONMENTS
    unset BUILDKITE_PLUGIN_RUN_RUNBOOK_PROJECT
    unset BUILDKITE_PLUGIN_RUN_RUNBOOK_RUNBOOK
    unset BUILDKITE_PLUGIN_RUN_RUNBOOK_SNAPSHOT
}

@test "Run runbook command with multiple environments" {
    export BUILDKITE_PLUGIN_RUN_RUNBOOK_ENVIRONMENTS_0="Dev"
    export BUILDKITE_PLUGIN_RUN_RUNBOOK_ENVIRONMENTS_1="Test"
    export BUILDKITE_PLUGIN_RUN_RUNBOOK_PROJECT="Test project"
    export BUILDKITE_PLUGIN_RUN_RUNBOOK_RUNBOOK="Test runbook"
    export 

    stub octo 'run-runbook --environment \"Dev\" --environment \"Test\" --project \"Test project\" --runbook \"Test runbook\" : echo octo command ran'

    run $PWD/hooks/command

    assert_output --partial "octo command ran"
    assert_success

    unstub octo
    unset BUILDKITE_PLUGIN_RUN_RUNBOOK_ENVIRONMENTS_0
    unset BUILDKITE_PLUGIN_RUN_RUNBOOK_ENVIRONMENTS_1
    unset BUILDKITE_PLUGIN_RUN_RUNBOOK_PROJECT
    unset BUILDKITE_PLUGIN_RUN_RUNBOOK_RUNBOOK
}

@test "Run runbook command with excluded machines" {
    export BUILDKITE_PLUGIN_RUN_RUNBOOK_ENVIRONMENTS="Test"
    export BUILDKITE_PLUGIN_RUN_RUNBOOK_EXCLUDE_MACHINES_0="WebA"
    export BUILDKITE_PLUGIN_RUN_RUNBOOK_EXCLUDE_MACHINES_1="WebB"
    export BUILDKITE_PLUGIN_RUN_RUNBOOK_PROJECT="Test project"
    export BUILDKITE_PLUGIN_RUN_RUNBOOK_RUNBOOK="Test runbook"

    stub octo 'run-runbook --environment \"Test\" --excludeMachines \"WebA,WebB\" --project \"Test project\" --runbook \"Test runbook\" : echo octo command ran'

    run $PWD/hooks/command

    assert_output --partial "octo command ran"
    assert_success

    unstub octo
    unset BUILDKITE_PLUGIN_RUN_RUNBOOK_ENVIRONMENTS
    unset BUILDKITE_PLUGIN_RUN_RUNBOOK_EXCLUDE_MACHINES_0
    unset BUILDKITE_PLUGIN_RUN_RUNBOOK_EXCLUDE_MACHINES_1
    unset BUILDKITE_PLUGIN_RUN_RUNBOOK_PROJECT
    unset BUILDKITE_PLUGIN_RUN_RUNBOOK_RUNBOOK
}