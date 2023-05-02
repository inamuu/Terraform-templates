import os
import urllib3
import json

http = urllib3.PoolManager()


def lambda_handler(event, context):
    print(event)
    url = os.environ['slack_webhook_url']
    msg = {"text": "```preprocess lambda の実行```"}
    encoded_msg = json.dumps(msg).encode("utf-8")
    resp = http.request("POST", url, body=encoded_msg)

    return {
        "statusCode": 200,
        "taskName": "preprocess",
    }
