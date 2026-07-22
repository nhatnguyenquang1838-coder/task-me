# Third-party notices

## Understand Anything

- Project: Egonex-AI/Understand-Anything
- Upstream repository: `Egonex-AI/Understand-Anything`
- Runtime pin: `6ae71878beb50226a1e4b7e2f52ac6468c86f74b`
- License: MIT
- Runtime and dashboard checkout: `vendor/understand-anything/` (generated locally, Git-ignored)

The upstream MIT license is available in the pinned runtime checkout at
`vendor/understand-anything/LICENSE`.

This bundle uses the upstream UA graph dashboard source, but removes the
separate marketing homepage mirror, large marketing GIFs, its demo graph, and
remote font requests. The dashboard loads this repository's canonical
`.ua/knowledge-graph.json` instead.
