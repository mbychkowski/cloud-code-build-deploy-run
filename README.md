# cloud-code-build-deploy-run

## Initializing Your Project

These instructions walk you through setting up your environment for this project.

You will need to clone this repository to the machine you want to use to set up your Google Cloud environment.

> **Note:** We recommended using Google Cloud Shell instead of your local laptop. Cloud Shell has all the tooling you need already pre-installed.

1. First authenticate to Google Cloud:

  ```bash
  gcloud auth application-default login
  ```

2. Set the new project as your context for the `gcloud` CLI:

  ```bash
  gcloud config set project <your-project-id>
  ```

3. Check if your authentication is ok and your project id is set:

  ```bash
  gcloud projects describe <your-project-id>
  ```

> __Note:__ You should see your `projectId` listed with an `ACTIVE` state.

5. Setup your unique `.env` variables to be used throughout the setup
process

  ```bash
  bash ./scripts/setup-env.sh
  ```

During this step you will be prompted for a couple inputs relative to your unique project. Most
inputs will contain defaults that might already be set, in which case go ahead and press [ENTER]
to accept and continue.

- The GitHub username/organization. This is the value used above when you cloned your fork.
- The name of the GitHub repository, by default this is set to `cloud-code-build-deploy-run`.
- Your unique Google Cloud project ID.
- Defaut region location for Google Cloud setup.

## Setting up GitHub Actions

Instructions for setting up and using GitHub Actions can be [found here](./.github/README.md).
