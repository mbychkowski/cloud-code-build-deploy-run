# Github Actions
This project has a number of examples of using Github Actions with Google Cloud, namely:

- Invoking Cloud Build to build our container
...

## Setting up GitHub Actions for Google Cloud

First we need to set up our GitHub environment to work with Google Cloud.

### Create a Fork

Setting up GitHub Actions for automated deployments with Terraform requires the Google Cloud administrator to create a fork of this repository, to personalize variable settings for your unique cloud environment.

1. Create a fork of this repository on the GitHub site. [Instructions here](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo).

2. Clone your new fork:

    ```bash
    git clone https://github.com/<your-github-username>/gke-github-deployment.git
    ```

### Enable Workload Identity Federation
To setup GitHub Actions securely with our Google Cloud environment we will need to do a one time setup for Workload Identity federation through a Google Cloud service account. [More info here](https://github.com/google-github-actions/auth?tab=readme-ov-file#workload-identity-federation-through-a-service-account).

Run this script:

```bash
bash ./scripts/enable-ghactions.sh
```

Make note of the returned output from running this script. It will look like this:

```
----- GITHUB ACTIONS ENV KEY/VALUE -----

GCP_SA_GITHUB_ACTIONS: sa-tf-gh-actions
GCP_PROJECT_ID: <your-project-id>
GCP_CUSTOMER_ID: <your-customer-id>
GCP_LOCATION: <gcp-region>
GCP_WI_PROVIDER_ID: <workload-id-provider-id>

----------------------------------------
```

You will need these values to finish setting up GitHub Actions.

> __Note:__ If using the GitHub CLI (`gh`) these values will be populated for you in declared repo.

### Enable IAM and Google Cloud Service Accounts to deploy resources to Cloud from GitHub Actions

Run this script:

```bash
bash ./scripts/enable-iam.sh
```

### Setup GitHub Actions In Your Fork

With the key/value pairs outputted from the script in the previous step, follow these steps:

1. In the Settings tab on the GitHub page for your fork, go to: **Secrets and Variables > Actions**
1. Click on the **Variables** tab
1. Click the **New repository variable** green button
1. Enter in your key value pairs

You should see the entries here if using `gh` cli. If not enter them manually.

## Invoking Cloud Build

You can use the **CloudBuild CI** GitHub action to build and push containers to Artifact Registry,
where they will later be used to deploy to a container runtime environment like Cloud Run or GKE.
