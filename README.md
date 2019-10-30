# GitHub Action for Serverless

This Action wraps the [Serverless Framework](https://serverless.com/framework/docs/getting-started/) CLI to enable common commands. See their documentation for usage and provider selection.

## v2 Breaking Changes

With the new [GitHub Actions Beta](https://github.blog/2019-08-08-github-actions-now-supports-ci-cd/) they're [migrating from HCL syntax to YAML](https://help.github.com/en/articles/migrating-github-actions-from-hcl-syntax-to-yaml-syntax). Version 2 updates this action to support the new syntax changes.

In addition, v1 offered a `SERVICE_ROOT` environment variable to configure the project subdirectory for the serverless service to deploy. Now this is a feature in the workflow config: [`working-directory`](https://help.github.com/en/articles/workflow-syntax-for-github-actions#jobsjob_idstepsworking-directory).

## Inputs

### `framework-version`

**Required** The Serverless Framework version to use. Default `1.55.1`.

## Usage

You'll first have to have a Serverless project as outlined in Serverless's [Getting Started](https://serverless.com/framework/docs/getting-started/). Suppose your provider of choice were Amazon AWS. A workflow could look as follows to checkout your code, install dependencies, and deploy to a Lambda function on AWS.

```yaml
name: Deploy Services

on:
  push:
    branches:
      - master

jobs:
  deploy:
    name: Deploy
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - name: Setup Node
        uses: actions/setup-node@v1
        with:
          node-version: "12.x"
      - name: Install Dependencies
        run: yarn install
      - name: Deploy using Serverless
        uses: aaronpanch/serverless-action@v2 # needed for YAML syntax
        with:
          framework-version: "1.55.1" # Optional, will use 1.55.1 by default
        run: serverless deploy
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          # or if using Severless credentials
          # SERVERLESS_ACCESS_KEY: ${{ secrets.SERVERLESS_ACCESS_KEY }}
```

### Secrets

Depending on the Serverless provider chosen, you'll need to supply appropriate credentials. The above example illustrates a typical AWS scenario or using the Serverless roles feature.

Typically, with any cloud provider, their particular authentication environment params are **Required**.
