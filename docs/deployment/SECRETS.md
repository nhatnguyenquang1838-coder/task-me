# GitHub Actions secrets

Configure these repository Actions secrets before marking the deployment PR ready for review:

- `VERCEL_TOKEN`
- `VERCEL_ORG_ID` = `team_4mKlLmlLe2pWbK5F5e10zck1`
- `VERCEL_PROJECT_ID` = `prj_Ca4CLbUy1A3Skp1ttHgradk4RYZn`

`VERCEL_TOKEN` is sensitive. The organization and project IDs are identifiers but are stored as secrets to keep workflows portable.
