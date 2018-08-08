from pathlib import Path
try:
    import requests
except ImportError:
    import sys
    print(sys.path)


URL = 'https://api.codic.jp/v1/engine/translate.json'
ALLOW_CASING = [
    'camel',
    'pascal',
    'lower underscore',
    'upper underscore',
    'hyphen'
]
ALLOW_ACRONYM_STYLE = [
    'MS naming guidelines',
    'camel strict',
    'literal'
]

with open('%s/.config/codic/api_token' % Path.home(), 'r') as f:
    TOKEN = f.read().rstrip()


def trans(
        text='',
        casing='lower underscore',
        project_id=None,
        acronym_style=None):
    params = {'text': text}
    assert casing in ALLOW_CASING, 'Invalid casing'
    if casing:
        params['casing'] = casing
    if project_id is not None:
        params['project_id'] = project_id
    if acronym_style:
        assert casing in ['camel', 'pascal'], (
            'Invalid casing. '
            'Must be camel or pascal'
        )
        assert acronym_style in ALLOW_ACRONYM_STYLE, 'Invalid acronym_style'
        params['acronym_style'] = acronym_style
    res = requests.get(
        url=URL,
        headers={'Authorization': 'Bearer ' + TOKEN},
        params=params
    )
    try:
        data = res.json()[0]
    except:
        return text
    return data['translated_text'] if data['successful'] else text
