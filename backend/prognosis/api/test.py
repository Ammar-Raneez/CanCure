import requests

BASE_URL = 'http://127.0.0.1:5000/prognosis/'
BONE_PROGNOSIS = BASE_URL + 'bone'
KIDNEY_PROGNOSIS = BASE_URL + 'kidney'

bone_prognosis_test_body = {
    'Blue.count': 16611,
    'red.count': 52475,
    'Blue.percentage': 1.584148,
    'red.percentage': 5.004406,
    'area': 81.252033,
    'circularity': 0.081106
}

kidney_prognosis_test_body = {
    'age': 48.0,
    'bp': 80.0,
    'al': 1.0,
    'su': 0.0,
    'rbc': 1,
    'bgr': 121.0,
    'bu': 36.0,
    'sc': 1.2,
    'sod': 4.5,
    'hemo': 15.4,
    'pcv': 44.0,
    'rc': 5.2,
    'htn': 1,
    'dm': 1,
    'cad': 0,
    'appet': 0,
    'ane': 0
}

response = requests.post(BONE_PROGNOSIS, data=bone_prognosis_test_body)
print(response.json())

response = requests.post(KIDNEY_PROGNOSIS, data=kidney_prognosis_test_body)
print(response.json())