import os
import urllib3
import json

http = urllib3.PoolManager()


def lambda_handler(event, context):
    print(event)

    task_name = "taskName is null" if "taskName" not in event else event["taskName"]
    task_id = "id is null" if "id" not in event else event["id"]

    if "result" in event:
        status_code = str(event["result"]["SdkHttpMetadata"]["HttpStatusCode"])

    if "statusCode" in event:
        status_code = str(event["statusCode"])

    url = os.environ['slack_webhook_url']

    msg = {"text": "```\n" +
           "taskname: " + task_name + "\n" +
           "id: " + task_id + "\n" +
           "statuscode: " + status_code + "\n" +
           "```"}
    encoded_msg = json.dumps(msg).encode("utf-8")
    resp = http.request("POST", url, body=encoded_msg)
    return {
        "message": event,
        "status_code": resp.status,
        "response": resp.data,
    }
