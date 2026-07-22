# Ready-for-review preview policy

1. Every pull request targeting `main` runs repository CI.
2. Draft pull requests do not deploy to Vercel Preview.
3. The `ready_for_review` event runs the preview job after CI passes.
4. Later commits on a ready PR redeploy the preview.
5. Merge to `main` runs the production workflow.

The root `vercel.json` includes a second guard through `ignoreCommand`. It ignores branch builds without a PR, Draft PRs, PRs targeting a branch other than `main`, and GitHub lookup failures.
