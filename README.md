# GitHub Action for Serverless

This Action wraps the [Serverless Framework](https://serverless.com/framework/docs/getting-started/) CLI to enable common commands. See their documentation for usage and provider selection.

## Usage

Suppose your provider of choice were Amazon AWS. A workflow could look as follows:

_Note:_ We're using the NPM Action to install project dependencies.

```workflow
workflow "Deploy via Serverless" {
  on = "push"
  resolves = ["deploy"]
}

action "install" {
  uses = "actions/npm@master"
  args = "install"
}

action "deploy" {
  needs = ["install"]
  uses = "aaronpanch/action-serverless@master"
  args = "deploy"
  secrets = [
    "AWS_ACCESS_KEY_ID",
    "AWS_SECRET_ACCESS_KEY",
  ]
}
```
