from mitmproxy import http
import json

with open("original_screen.json") as f:

    data = json.load(f)

    def response(flow: http.HTTPFlow) -> None:
        if "screen" in flow.request.url:
            flow.response.text = json.dumps(data)
