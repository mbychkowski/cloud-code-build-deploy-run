#!/bin/bash

if ! [ $(command -v gh) ]
then
  echo "gh: command not found"
  echo "Consider installing gh cli at: https://github.com/cli/cli#installation"
fi

# figure out if we're logged into the gh CLI
gh auth status > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "gh: command found and logged into GitHub"
  GH_AVAILABLE=true
fi

# Obtain possible defaults of key environment variables:
_GITHUB_REPO="gke-github-deployment"
if [ $GH_AVAILABLE ]; then
  _GITHUB_ORG=$(gh repo view --json owner -q ".owner.login")
  _GITHUB_REPO=$(gh repo view --json name -q ".name")
fi
_GCP_SA_GITHUB_ACTIONS="sa-gh-actions"
_GCP_PROJECT_ID=$(gcloud config get-value project)
_GCP_LOCATION=$(gcloud config get-value compute/region)
_GCP_LOCATION=${_GCP_LOCATION:-us-central1}

# Request acceptance of defaults or alternatives
read -p "Enter GitHub organization or owner [${_GITHUB_ORG}]: " GITHUB_ORG
read -p "Enter GitHub repository name [${_GITHUB_REPO}]: " GITHUB_REPO
read -p "Enter GCP project ID [${_GCP_PROJECT_ID}]: " GCP_PROJECT_ID
read -p "Enter default value region for this setup [${_GCP_LOCATION}]: " GCP_LOCATION

GITHUB_ORG="${GITHUB_ORG:-`echo $_GITHUB_ORG`}"
GITHUB_REPO="${GITHUB_REPO:-`echo $_GITHUB_REPO`}"
GCP_SA_GITHUB_ACTIONS="${GCP_SA_GITHUB_ACTIONS:-`echo $_GCP_SA_GITHUB_ACTIONS`}"
GCP_PROJECT_ID="${GCP_PROJECT_ID:-`echo $_GCP_PROJECT_ID`}"
GCP_LOCATION="${GCP_LOCATION:-`echo $_GCP_LOCATION`}"

gcloud config set project ${GCP_PROJECT_ID} 2> /dev/null
gcloud config set compute/region ${GCP_LOCATION} 2> /dev/null

if [ $GH_AVAILABLE ]; then
  gh repo set-default ${GITHUB_ORG}/${GITHUB_REPO}
fi

GCLOUD_CONFIG=$(gcloud config list 2> /dev/null)

cat << EOF

----------------------------------------
-------- GOOGLE CLOUD CONFIGURED -------
----------------------------------------

${GCLOUD_CONFIG}

----------------------------------------
----- GITHUB ACTIONS ENV KEY/VALUE -----
----------------------------------------

GITHUB_ORG:            ${GITHUB_ORG}
GITHUB_REPO:           ${GITHUB_REPO}
GCP_SA_GITHUB_ACTIONS: ${GCP_SA_GITHUB_ACTIONS}
GCP_PROJECT_ID:        ${GCP_PROJECT_ID}
GCP_LOCATION:          ${GCP_LOCATION}

EOF

cat << EOF > .env
GITHUB_ORG="${GITHUB_ORG}"
GITHUB_REPO="${GITHUB_REPO}"
GCP_SA_GITHUB_ACTIONS="${GCP_SA_GITHUB_ACTIONS}"
GCP_PROJECT_ID="${GCP_PROJECT_ID}"
GCP_LOCATION="${GCP_LOCATION}"
EOF