# Contributing
Make sure to review the module [README](../README.md) to understand the scope of this module.

## Table of Contents
1. [Tooling](#Tooling)
2. [Structure](#Structure)
3. [Changes](#Changes)

## Tooling
To contribute to this Terraform codebase, it is recommended to install several tools to aid development. All packages may be installed with the Brew package manager on Mac or Linux. Windows users are encouraged to install Windows Subsystem for Linux (WSL) with an Ubuntu image.

### Install TFEnv and Terraform
TFEnv is an optional tool enabling the installation of multiple versions of Terraform. It is useful in case the developer is working on seveal Terraform projects pinned to specific Terraform versions:
```bash
brew install tfenv
tfenv install $VERSION # Where $VERSION is the version of Terraform to install, e.g. 1.3.0
```

### Install Pre-Commit Hooks
This project supports the use of Pre-Commit. Pre-Commit is a tool that can run checks against your code upon committing changes to a branch. Checks need to pass, otherwise the changes will not be committed. Some checks will automatically fix files (e.g. trailing whitespace). In particular, this tool supports Terraform-specific checks to ensure Terraform code is formatted correctly and executable:
```bash
brew install pre-commit
pre-commit install
```

### Install Terraform-Docs
Terraform-Docs scans Terraform code and automatically generates documentation for any modules. Documentation includes input variables, outputs, dependencies and more. Documentation is saved as a `README` file in the root of each module. The Pre-Commit hook for Terraform-Docs will ensure documtnation is kept up to date as the Terraform codebase is updated:
```bash
brew install terraform-docs
```

### Install TFLint
TFLint is a linting tool for Terraform that ensures the Terraform codebase is correct and executable. Warnings will be provided for unsupported values, redudnant variables, and many more checks. The TFLint Pre-Commit hook will run these checks automatically upon commit. After installation, TFLint must be initialised from the root of the repo, and makes use of the `.tflint.hcl` file for its configuration:
```bash
brew install tflint
tflint --init
```

### Install Checkov
Checkov is a security tool for Terraform that ensures resources defined for a specific provider (in this case Azure) meet security best practice. For example, Checkov will warn if storage accounts are not configured to use TLS1.2. The Pre-Commit hook will run these checks automatically upon commit:
```bash
brew install checkov
```

In some scenarios Checkov may report configuration issues which are intentional or not of concern in practice. In order to bypass checks, a comment may be added to the Terraform resource it warns about. The comment should start with `checkov:skip=` followed by the failed check ID (e.g. `CKV_AZURE_109`) and finally a comment providing context on why the check should be ignored:
```
resource "azurerm_storage_account" "my_storage_account" {
  #checkov:skip=CKV_AZURE_109: Skip reason

  ...
}
```

## Structure
The module structure is as follows:
```
.
+-- .config
|   +-- .checkov.yaml
|   +-- .tflint.hcl
|
+-- .github
|   +-- workflows
|       +-- ci.yaml
|
+-- docs
|   +-- architecture.svg
|   +-- CODEOWNERS
|   +-- CONTRIBUTING.md
|   +-- PULL_REQUEST_TEMPLATE.md
|
+-- locals.tf
+-- main.tf
+-- outputs.tf
+-- README.md
+-- variables.tf
```

- The `.config` folder contains configuration files used by `pre-commit`.
- The `.github` folder contains GitHub Action workflows, notably the CI pipeline used for validation checks.
- The `docs` folder contains module documentation and images such as architecture diagrams.
- The root of the repository contains the module files:
  - `README.md` describes the module scope, example usage, and includes `terraform` inputs, outputs and requirements populated automatically by the `terraform-docs` `pre-commit` hook.
  - `*.tf` are the `terraform` files which comrpise the module.

### Terraform File Guidance
- All modules should have a `main.tf`, `outputs.tf` and `variables.tf`.
  - For larger modules, it is common to have additional `.tf` files for individual services to ease maintenance. In that case, `main.tf` should contain only the `terraform` block describing module dependencies (required submodules and their versions).
  - Use a `locals.tf` file to create `local` variables which are often the result of complex logic. The `locals.tf` file may also contain shared `data` blocks such as the target resource group.

## Changes
This template contains a Pull Request template to ensure certain conditions are met before merging any changes. Please consider the following before raising a pull request:
- Always create a new branch for developing new changes.
- [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/#summary) are the preferred style of commit messages, but this is not enforced.
- Use `pre-commit` hooks locally during development to catch issues before committing changes.
- The `CODEOWNERS` file should be updated to reflect changes in module ownership as required.
- The module `README` file should be updated to reflect changes to inputs, outputs, and examples.
- All checks from the integration pipeline should pass before raising a pull request.

### Integration Pipeline
This template contains a GitHub Action workflow for continuous integration which runs on pushes to any branch. The CI pipeline is intended to ensure code quality and should pass before raising a pull request. The below table outlines each step of the `ci.yaml` pipeline:

| Step | Description |
|------|-------------|
| Checkout Repo | Copies the repository to the GitHub Actions Runner |
| Terraform Setup | Downloads the latest Terraform version |
| TFLint Setup | Downloads the latest TFLint version |
| Terrform Init | Initialises the Terraform codebase without backend |
| Terraform Format | Checks the format of Terraform files |
| Terraform Validate | Validates Terraform files to ensure they are executable |
| TFLint Validate | Runs the TFLint tool for linting and validation purposes |
| Checkov Validate | Runs the Checkov tool to detect security misconfigurations |
