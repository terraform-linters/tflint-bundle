# tflint-bundle

~~**DEPRECATED: This project is deprecated. We strongly recommend migrating to plugin management with `.tflint.hcl` and Renovate.**~~

Forked from the original.

A Docker image with TFLint and ruleset plugins

```console
docker pull ghcr.io/dalaran/tflint-bundle
```

Bundled versions:

- TFLint v0.48.0
- tflint-ruleset-aws v0.26.0
- tflint-ruleset-azurerm v0.24.0
- tflint-ruleset-google v0.24.0

These ruleset plugins are installed manually. If you want to enable it, just set `enabled = true` without specifying the version.

```hcl
plugin "aws" { enabled = true }
plugin "azurerm" { enabled = true }
plugin "google" { enabled = true }
```
