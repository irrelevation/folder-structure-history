# folder-structure-history

Visualise how your folder structure changed over time

## Steps

1. get all commit hashes of the branch: `git log --pretty="format:%H"`
2. for each commit hash, get the folder structure: `git ls-tree -r {{hash}} --name-only`
3. visualise it `| tree --fromfile .`
