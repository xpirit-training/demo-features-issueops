# Demo repository for IssueOps

Custom ISSUE_TEMPLATE for creating new repositories via issue forms.

Workflow for auto provisioning new repositories based on issues and administer them.


# Queries

## jq

### Create repo name

```
COMPANY=$(jq -r '.Company' [issue-body] | sed 's/ (.*)//g' | sed 's/ /-/g' | tr '[:upper:]' '[:lower:]')

TEAM=$(jq -r '.Team' [issue-body] | sed 's/-.*//g' | sed 's/ /-/g' | tr '[:upper:]' '[:lower:]')

PROJECT=$(jq -r '.Project' [issue-body] | sed 's/ /-/g' | tr '[:upper:]' '[:lower:]')

RNAME=$(jq -r '.Name' [issue-body] | sed 's/ /-/g' | tr '[:upper:]' '[:lower:]')

REPO=${COMPANY}-${TEAM}-${PROJECT}-${RNAME}
```

## yq

### replace companies, teams & projects

testing:

```
# Companies
COMPANIES=$(find .github/org/companies -mindepth 1 -maxdepth 1 -type d -exec sh -c 'echo - $(basename "$1") \($(yq '.number' "$1"/metadata.yml)\)' sh {} \; | sort) yq '(.body[] | select(.type=="dropdown" and .attributes.label=="Company") | .attributes.options) |=env(COMPANIES)' .github/ISSUE_TEMPLATE/repo-request.yml

# Teams
TEAMS=$(find .github/org/companies/*/teams -mindepth 1 -maxdepth 1 -type d -exec sh -c 'echo - $(yq '.id' "$1"/metadata.yml)-$(basename "$1")' sh {} \; | sort) yq '(.body[] | select(.type=="dropdown" and .attributes.label=="Team") | .attributes.options) |=env(TEAMS)' .github/ISSUE_TEMPLATE/repo-request.yml

# Projects
PROJECTS=$(find .github/org/companies/*/teams/*/projects -mindepth 1 -maxdepth 1 -type d -exec sh -c 'echo - $(basename "$1")' sh {} \; | sort) yq '(.body[] | select(.type=="dropdown" and .attributes.label=="Project") | .attributes.options) |=env(PROJECTS)' .github/ISSUE_TEMPLATE/repo-request.yml
```