#!/usr/bin/env python3
from __future__ import annotations
import json, sys
from common import repo_root, load_json

def main():
    q=' '.join(sys.argv[1:]).lower().strip()
    if not q: raise SystemExit('usage: query_knowledge.py <id-or-text>')
    root=repo_root(); results=[]
    for p in [root/'.ua/knowledge-graph.json', *sorted((root/'.ua/extensions').glob('*.json'))]:
        g=load_json(p, {'nodes':[]})
        for n in g.get('nodes',[]):
            hay=json.dumps(n, ensure_ascii=False).lower()
            if q in hay: results.append({'graph':p.relative_to(root).as_posix(),'node':n})
    print(json.dumps(results[:50], indent=2, ensure_ascii=False))
if __name__=='__main__': main()
