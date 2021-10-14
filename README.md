# tflint-bundle

A Docker image with TFLint and ruleset plugins

```console
docker pull ghcr.io/terraform-linters/tflint-bundle
```

Bundled versions:

- TFLint v0.33.0
- tflint-ruleset-aws v0.8.0
- tflint-ruleset-azurerm v0.13.2
- tflint-ruleset-google v0.13.0

These ruleset plugins are installed manually. If you want to enable it, just set `enabled = true` without specifying the version.

```hcl
plugin "aws" { enabled = true }
plugin "azurerm" { enabled = true }
plugin "google" { enabled = true }
```
