# Run Runbook Buildkite Plugin

![image](https://user-images.githubusercontent.com/71493/153728204-b1982870-86f9-4e91-b317-bb9247e19da8.png)

This is a [Buildkite](https://buildkite.com/) plugin to run a runbook in [Octopus Deploy](https://octopus.com/).

**This plugin requires [Octopus CLI](https://octopus.com/downloads/octopuscli) to be installed on the Buildkite agent.**

## Runbooks in Octopus Deploy

Runbooks automate routine maintenance and emergency operations tasks, such as infrastructure provisioning, database management, and website failover and restoration. Runbooks include all the necessary permissions for the infrastructure they run on, so anybody on the team can execute the runbook, and because they're managed in Octopus there's a complete audit trail. Runbooks can be parameterized with prompted variables so that human interaction is required.

## Examples

Incorporate the following step in your `pipeline.yml` to create a release in Octopus Deploy:

### Basic examples

**Run a runbook using the published snapshot**

```yml
steps:
  - label: ":octopus-deploy: Run runbook in Octopus Deploy"
    plugins:
      - OctopusDeploy/run-runbook#v0.1.1:
          api_key: "${MY_OCTOPUS_API_KEY}"
          environments: "Test"
          project: "Hello World"
          runbook: "Greeting"
          server: "${MY_OCTOPUS_SERVER}"
```

**Run a runbook using a specific snapshot**

```yml
steps:
  - label: ":octopus-deploy: Run runbook in Octopus Deploy"
    plugins:
      - OctopusDeploy/run-runbook#v0.1.1:
          api_key: "${MY_OCTOPUS_API_KEY}"
          environments: "Test"
          project: "Hello World"
          runbook: "Greeting"
          server: "${MY_OCTOPUS_SERVER}"
          snapshot: "KGHSL3L"
```

**Run a runbook in multiple environments**

```yml
steps:
  - label: ":octopus-deploy: Run a runbook in Octopus Deploy"
    plugins:
      - OctopusDeploy/run-runbook#v0.1.1:
          api_key: "${MY_OCTOPUS_API_KEY}"
          environments:
            - "Dev"
            - "Test"
          project: "Hello World"
          runbook: "Greeting"
          server: "${MY_OCTOPUS_SERVER}"
```

## Configuring

### `OCTOPUS_CLI_SERVER`

Your Octopus Server URL should be set to this environment variable, or you can use `server` in the steps of your pipeline instead.

### `OCTOPUS_CLI_API_KEY`

Your Octopus Server API key should be set to this environment variable, either in your pipeline’s environment variable settings or exposed in an [environment hook](https://buildkite.com/docs/pipelines/secrets#storing-secrets-in-environment-hooks). If you need different keys for different steps in your pipeline use `api_key` instead.

## 📥 Inputs

**The following input is required:**

| Name           | Description                                                                                               |
| :------------- | :-------------------------------------------------------------------------------------------------------- |
| `environments` | A comma-delimited list of environments in Octopus Deploy in which to run (i.e. "Dev,Test,Prod").          |
| `project`      | The name or ID of the project associated with this runbook.                                               |
| `runbook`      | The name or ID of the runbook. If the name is supplied, the `project` input value must also be specified. |

**The following inputs are optional:**

| Name                     | Description                                                                                                                                                                                                                       |  Default   |
| :----------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--------: |
| `api_key`                | The environment variable that is configured with your Octopus Server API key used to access Octopus Deploy. Use this if you need to specify different keys for different steps in your pipeline.                                  |
| `cancel_on_timeout`      | Cancel the deployment if `deployment_timeout` is exceeded (default: 10 minutes).                                                                                                                                                  |  `false`   |
| `config_file`            | The path to a configuration file of default values with one `key=value` per line.                                                                                                                                                 |            |
| `debug`                  | Enable debug logging.                                                                                                                                                                                                             |  `false`   |
| `exclude_machines`       | A comma-separated list of machine names to exclude in the deployed environment. If empty, all machines in the environment will be considered.                                                                                     |            |
| `force_package_download` | Force download of installed packages.                                                                                                                                                                                             |  `false`   |
| `guided_failure`         | Use [Guided Failure mode](https://octopus.com/docs/releases/guided-failures).                                                                                                                                                     |  `false`   |
| `ignore_ssl_errors`      | Ignore certificate errors when communicating with Octopus Deploy. Warning: enabling this option creates a security vulnerability.                                                                                                 |  `false`   |
| `log_level`              | The log level; valid options are `verbose`, `debug`, `information`, `warning`, `error`, and `fatal`.                                                                                                                              |  `debug`   |
| `no_raw_log`             | Print the raw log of failed tasks.                                                                                                                                                                                                |  `false`   |
| `no_run_after`           | The time at which scheduled runbook run should expire, specified as any valid DateTimeOffset format, and assuming the time zone is the current local time zone.                                                                   |            |
| `password`               | The password to used to authenticate with Octopus Deploy. It is strongly recommended to retrieve this value from a GitHub secret.                                                                                                 |            |
| `proxy`                  | The URL of a proxy to use (i.e. `https://proxy.example.com`).                                                                                                                                                                     |            |
| `proxy_password`         | The password used to connect to a proxy. It is strongly recommended to retrieve this value from a GitHub secret. If `proxy_username` and `proxy_password` are omitted and `proxy` is specified, the default credentials are used. |            |
| `proxy_username`         | The username used to connect to a proxy. It is strongly recommended to retrieve this value from a GitHub secret.                                                                                                                  |            |
| `raw_log_file`           | Redirect the raw log of failed tasks to a file.                                                                                                                                                                                   |            |
| `run_at`                 | The time at which runbook run should start (scheduled run), specified as any valid DateTimeOffset format, and assuming the time zone is the current local time zone.                                                              |            |
| `run_check_sleep_cycle`  | The length of time that should elapse between runbook run status checks (format: HH:MM:SS).                                                                                                                                       | `00:00:10` |
| `run_timeout`            | The maximum length of time that the console session will wait for the runbook run to finish. Note: This will not stop the run. This input requires the `wait_for_run` input value to be `true` (format: HH:MM:SS).                | `00:10:00` |
| `server`                 | The base URL hosting Octopus Deploy (i.e. `https://octopus.example.com`). It is recommended to retrieve this value from an environment variable.                                                                                  |            |
| `show_progress`          | Show progress of the runbook.                                                                                                                                                                                                     |  `false`   |
| `skip`                   | Skip a step by name.                                                                                                                                                                                                              |            |
| `snapshot`               | The name or ID of the snapshot to run. If not supplied, this action will attempt to use the published snapshot.                                                                                                                   |            |
| `space`                  | The name or ID of a space within which this command will be executed. If omitted, the default space will be used.                                                                                                                 |            |
| `specific_machines`      | A comma-separated list of machine names to target in the deployed environment. If not specified all machines in the environment will be considered.                                                                               |            |
| `tenant`                 | Create a deployment for the tenant with this name or ID; specify this argument multiple times to add multiple tenants or use a wildcard (`*`) to deploy to all tenants who are ready for this release (according to lifecycle).   |            |
| `tenant_tag`             | Create a deployment for tenants matching this tag; specify this argument multiple times to build a query/filter with multiple tags.                                                                                               |            |
| `timeout`                | A timeout value for network operations (in seconds).                                                                                                                                                                              |   `600`    |
| `username`               | The username used to authenticate with Octopus Deploy. You must provide `api_key` or `username` and `password`. It is strongly recommended to retrieve this value from a GitHub secret.                                           |            |
| `variable`               | Values for any prompted variables (format: `Label:Value`). For JSON values, embedded quotation marks should be escaped with a backslash.                                                                                          |            |
| `wait_for_run`           | Indicates whether or not to wait synchronously for deployment to finish.                                                                                                                                                          |  `false`   |

## Developing

To run the tests:

```shell
docker-compose run --rm tests
```

To lint the plugin:

```shell
docker-compose run --rm lint
```

## 🤝 Contributions

Contributions are welcome! :heart: Please read our [Contributing Guide](CONTRIBUTING.md) for information about how to get involved in this project.
