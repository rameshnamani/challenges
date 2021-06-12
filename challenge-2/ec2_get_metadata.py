import requests
import json

url = 'http://169.254.169.254/latest/'


def prepare(url, arr):
    data = {}
    for x in arr:
        new_url = url + x
        response = requests.get(new_url)
        t = response.text
        if x[-1] == "/":
            keys = response.text.splitlines()
            data[x[:-1]] = prepare(new_url, keys)
        elif is_json(t):
            data[x] = json.loads(t)
        else:
            data[x] = t
    return data


def metadata():
    get_key = ["meta-data/"]
    r = prepare(url, get_key)
    return r


def json_response():
    m = metadata()
    output = json.dumps(m, indent=4)
    return output


def is_json(myjson):
    try:
        json.loads(myjson)
    except ValueError:
        return False
    return True


if __name__ == '__main__':
    print(json_response())
