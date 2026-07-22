#!/usr/bin/env bash
set -euo pipefail

# Vercel contract: exit 0 = ignore deployment, exit 1 = continue build.
if [ "${VERCEL_ENV:-}" = "production" ] || [ "${VERCEL_GIT_COMMIT_REF:-}" = "main" ]; then
  echo '[vercel] Production/main build allowed.'
  exit 1
fi

PR_ID="${VERCEL_GIT_PULL_REQUEST_ID:-}"
if [ -z "$PR_ID" ]; then
  echo '[vercel] No pull request is associated with this branch; preview ignored.'
  exit 0
fi

OWNER="${VERCEL_GIT_REPO_OWNER:-nhatnguyenquang1838-coder}"
REPO="${VERCEL_GIT_REPO_SLUG:-task-me}"
export PR_ID OWNER REPO

node <<'NODE'
const https = require('node:https');
const { PR_ID, OWNER, REPO } = process.env;
const request = https.get({
  hostname: 'api.github.com',
  path: `/repos/${OWNER}/${REPO}/pulls/${PR_ID}`,
  headers: {
    Accept: 'application/vnd.github+json',
    'User-Agent': 'task-me-vercel-build-gate',
    'X-GitHub-Api-Version': '2022-11-28',
  },
}, (response) => {
  let body = '';
  response.setEncoding('utf8');
  response.on('data', (chunk) => { body += chunk; });
  response.on('end', () => {
    if (response.statusCode !== 200) {
      console.error(`[vercel] GitHub PR lookup failed: HTTP ${response.statusCode}`);
      process.exit(0);
    }
    const pullRequest = JSON.parse(body);
    if (pullRequest.base?.ref !== 'main') {
      console.log(`[vercel] PR targets ${pullRequest.base?.ref ?? 'unknown'}, not main; preview ignored.`);
      process.exit(0);
    }
    if (pullRequest.draft === true) {
      console.log('[vercel] PR is Draft; preview ignored.');
      process.exit(0);
    }
    console.log('[vercel] PR is Ready for review and targets main; preview allowed.');
    process.exit(1);
  });
});
request.on('error', (error) => {
  console.error(`[vercel] GitHub PR lookup error: ${error.message}`);
  process.exit(0);
});
NODE
