# tflint-bundle

A Docker image with TFLint and ruleset plugins

```console
docker pull ghcr.io/terraform-linters/tflint-bundle
```

Bundled versions:

- TFLint v0.46.0
- tflint-ruleset-aws v0.22.1
- tflint-ruleset-azurerm v0.22.0
- tflint-ruleset-google v0.22.2

These ruleset plugins are installed manually. If you want to enable it, just set `enabled = true` without specifying the version.

```hcl
plugin "aws" { enabled = true }
plugin "azurerm" { enabled = true }
plugin "google" { enabled = true }
```
