import os
import urllib3
import json

http = urllib3.PoolManager()


def lambda_handler(event, context):
    url = os.environ['slack_webhook_url']
    msg = {"text": json.dumps(event)}
    encoded_msg = json.dumps(msg).encode("utf-8")
    resp = http.request("POST", url, body=encoded_msg)
    print(
        {
            "message": event,
            "status_code": resp.status,
            "response": resp.data,
        }
    )
