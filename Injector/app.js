var appTree = {
    'type':'Tab',
    'subnodes':[
                {'type':'Label', 'properties': {'text': 'First'}},
                {'type':'Label', 'properties': {'text': 'Second'}},
                {'type':'Navigator','properties': {'title': 'NavNav'},
                'subnodes':[
                            {'type':'Label', 'text': 'Root'},
                            {'type':'Label', 'text': 'Middle'},
                            {'type':'Label', 'text': 'Top'}
                            ]}
                ]};