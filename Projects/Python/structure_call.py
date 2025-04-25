from mitmproxy import http
import json

with open('original_structure.json') as f:

    data = json.load(f)

    def response(flow: http.HTTPFlow) -> None:
        if "structure" in flow.request.url:
            flow.response.text = json.dumps(data)
