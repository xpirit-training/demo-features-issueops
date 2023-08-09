# Demo Repository for IssueOps

Custom ISSUE_TEMPLATE for creating new repositories via issue forms.

Workflow for auto provisioning new repositories based on issues and administer them.

## Workflows

### `repo-request.yml`

Workflow that is triggered by submitted repository request issue.

### `update-repo-request-template.yml`

Workflow that is triggered by any changes in the `./org` folder. The workflow reads the contents from the folder expecting the following structure:

```
org/
├── company-1/
│   ├── metadata.yml
│   └── teams/
│       └── team-1/
│           ├── metadata.yml
│           └── projects/
│               ├── project-1/
│               └── project-2/
└── company-n/
    ├── metadata.yml
    └── teams/
        └── team-n/
            ├── metadata.yml
            └── projects/
                └── project-n/
```

The `org` is defined of a set of `company` which has a set of `teams`. Each team has a set of `projects`. In order to define so general properties on `company` as well as `team` level, each of those has a `metadata.yml` This file holds properties such as team manager oder team identifier.

Any change to the structure will trigger the workflow and populate the issue template.

## Queries

### jq

#### Create repo name

```
COMPANY=$(cat [issue-body] | jq -r '.Company' | sed 's/ (.*)//g' | sed 's/ /-/g' | tr '[:upper:]' '[:lower:]')

TEAM=$(cat [issue-body] | jq -r '.Team' | sed 's/-.*//g' | sed 's/ /-/g' | tr '[:upper:]' '[:lower:]')

PROJECT=$(cat [issue-body] | jq -r '.Project' | sed 's/ /-/g' | tr '[:upper:]' '[:lower:]')

RNAME=$(cat [issue-body] | jq -r '.Name' | sed 's/ /-/g' | tr '[:upper:]' '[:lower:]')

REPO=${COMPANY}-${TEAM}-${PROJECT}-${RNAME}
```

### yq

#### Replace companies, teams & projects

testing:

```
# Companies
COMPANIES=$(find ./org/companies -mindepth 1 -maxdepth 1 -type d -exec sh -c 'echo - $(basename "$1") \($(yq '.number' "$1"/metadata.yml)\)' sh {} \; | sort) yq '(.body[] | select(.type=="dropdown" and .attributes.label=="Company") | .attributes.options) |=env(COMPANIES)' .github/ISSUE_TEMPLATE/repo-request.yml

# Teams
TEAMS=$(find ./org/companies/*/teams -mindepth 1 -maxdepth 1 -type d -exec sh -c 'echo - $(yq '.id' "$1"/metadata.yml)-$(basename "$1")' sh {} \; | sort) yq '(.body[] | select(.type=="dropdown" and .attributes.label=="Team") | .attributes.options) |=env(TEAMS)' .github/ISSUE_TEMPLATE/repo-request.yml

# Projects
PROJECTS=$(find ./org/companies/*/teams/*/projects -mindepth 1 -maxdepth 1 -type d -exec sh -c 'echo - $(basename "$1")' sh {} \; | sort) yq '(.body[] | select(.type=="dropdown" and .attributes.label=="Project") | .attributes.options) |=env(PROJECTS)' .github/ISSUE_TEMPLATE/repo-request.yml
```