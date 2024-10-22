#!/bin/bash

# Source environment variables from .env file (see scripts/setup-env.sh)
source .env

# Add roles to Google Cloud Service Account.
for SUCCINCT_ROLE in \
    artifactregistry.admin \
    cloudbuild.connectionAdmin \
    cloudbuild.builds.builder \
    clouddeploy.jobRunner \
    clouddeploy.releaser \
    pubsub.subscriber \
    resourcemanager.projectIamAdmin \
    run.developer \
    run.invoker \
    storage.admin \
    storage.objectAdmin \
    ; do

  gcloud projects add-iam-policy-binding "$GCP_PROJECT_ID" \
    --member="serviceAccount:${GCP_SA_GITHUB_ACTIONS}@${GCP_PROJECT_ID}.iam.gserviceaccount.com" \
    --role "roles/$SUCCINCT_ROLE" \
    --condition=None

done