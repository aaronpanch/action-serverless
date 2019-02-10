# GitHub Action for Serverless

This Action wraps the [Serverless Framework](https://serverless.com/framework/docs/getting-started/) CLI to enable common commands. See their documentation for usage and provider selection.

## Usage

You'll first have to have a Serverless project as outlined in Serverless's [Getting Started](https://serverless.com/framework/docs/getting-started/).  Suppose your provider of choice were Amazon AWS. A workflow could look as follows to install dependencies, and deploy to a Lambda function.

_Note:_ We're first using the NPM Action to install project dependencies, then running `serverless deploy` via the action.

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

### Secrets

Depending on the Serverless provider chosen, you'll need to supply appropriate credentials.  The above example illustrates a typical AWS scenario, but Serverless supports other cloud providers.

Typically, with any cloud provider, their particular authentication environment params are **Required**.

### Environment Variables

- `SERVICE_ROOT` - **Optional**.  To specify a particular subdirectory of your project that contains the Serverless service (the directory with the `serverless.yml` file) you can specify a `SERVICE_ROOT`.  This action will `cd` into that directory then execute commands.  The default root is `.` (project root).

#### Example

To navigate and deploy two services (in this example "Users" and "Admins") in different subdirectories:

```hcl
action "Deploy Users Service" {
  uses = "aaronpanch/action-serverless@master"
  args = "deploy"
  env = {
    SERVICE_ROOT = "users_service"
  }
  secrets = [
    "AWS_ACCESS_KEY_ID",
    "AWS_SECRET_ACCESS_KEY",
  ]
}

action "Deploy Admin Service" {
  uses = "aaronpanch/action-serverless@master"
  args = "deploy"
  env = {
    SERVICE_ROOT = "admin_service"
  }
  secrets = [
    "AWS_ACCESS_KEY_ID",
    "AWS_SECRET_ACCESS_KEY",
  ]
}
```
