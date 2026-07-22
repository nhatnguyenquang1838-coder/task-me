#!/usr/bin/env python3
from __future__ import annotations
from collections import defaultdict
from common import repo_root, load_json, save_json

def main():
    root=repo_root(); graphs=[]
    for p in [root/'.ua/knowledge-graph.json', *sorted((root/'.ua/extensions').glob('*.json'))]:
        graphs.append(load_json(p, {'nodes':[],'edges':[]}))
    by_type=defaultdict(list); outgoing=defaultdict(list); incoming=defaultdict(list)
    for g in graphs:
        for n in g.get('nodes',[]): by_type[n.get('type','unknown')].append(n.get('id'))
        for e in g.get('edges',[]):
            outgoing[e.get('source')].append(e); incoming[e.get('target')].append(e)
    save_json(root/'.ua/indexes/by-type.json',dict(by_type))
    save_json(root/'.ua/indexes/outgoing.json',dict(outgoing))
    save_json(root/'.ua/indexes/incoming.json',dict(incoming))
    print('INDEXES_BUILT')
if __name__=='__main__': main()
