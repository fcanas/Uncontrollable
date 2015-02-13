var appTree = {
    'type':'Tab',
    'subnodes':[
                {'type':'Label', 'properties': {'text': 'First'}},
                {'type':'Label', 'properties': {'text': 'Second'}},
                {'type':'Navigator','properties': {'title': 'NavNav'},
                'subnodes':[
                            {'type':'Label', 'properties': {'text': 'Root'}},
                            {'type':'Label', 'properties': {'text': 'Middle'}},
                            {'type':'Label', 'properties': {'text': 'Top'}}
                            ]}
                ]};