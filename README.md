# Demo repository for IssueOps

Custom ISSUE_TEMPLATE for creating new repositories via issue forms.

Workflow for auto provisioning new repositories based on issues and administer them.


## jq

### Replace

testing:

```
# Companies
COMPANIES=$(find .github/org/companies -mindepth 1 -maxdepth 1 -type d -exec sh -c 'basename "$0" | yq [.]' {} \; | sort) yq '(.body[] | select(.type=="dropdown" and .attributes.label=="Company") | .attributes.options) |=env(COMPANIES)' .github/ISSUE_TEMPLATE/repo-request.yml

# Teams
TEAMS=$(find .github/org/companies/*/teams -mindepth 1 -maxdepth 1 -type d -exec sh -c 'basename "$0" | yq [.]' {} \; | sort) yq '(.body[] | select(.type=="dropdown" and .attributes.label=="Team") | .attributes.options) |=env(TEAMS)' .github/ISSUE_TEMPLATE/repo-request.yml

# Projects
PROJECTS=$(find .github/org/companies/*/teams/*/projects -mindepth 1 -maxdepth 1 -type d -exec sh -c 'basename "$0" | yq [.]' {} \; | sort) yq '(.body[] | select(.type=="dropdown" and .attributes.label=="Project") | .attributes.options) |=env(PROJECTS)' .github/ISSUE_TEMPLATE/repo-request.yml
```