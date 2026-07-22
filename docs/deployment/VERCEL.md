# Vercel deployment

## Policy

- Every pull request targeting `main` runs CI.
- Draft pull requests never deploy a preview.
- A preview is deployed on `ready_for_review`, `synchronize`, or `reopened` only when the PR is not Draft.
- Production deploys only from `main`.

## Required GitHub Actions secrets

- `VERCEL_TOKEN`
- `VERCEL_ORG_ID`
- `VERCEL_PROJECT_ID`

The project and organization IDs are identifiers, not credentials, but they are kept as Actions secrets so the workflow can be reused across forks and environments.

## Vercel project settings

The root `vercel.json` builds the upstream UA dashboard in static demo mode and publishes the canonical root `.ua/knowledge-graph.json`.

The `ignoreCommand` is an additional guard for Vercel Git Integration. It allows production/main builds and only allows preview builds for non-Draft PRs targeting `main`.

GitHub Actions is the authoritative trigger for the Ready-for-review preview because the `ready_for_review` event does not create a Git commit by itself.
