import os
import json


def lambda_handler(event, context):
    msg = {"text": json.dumps(event)}
    print(msg)

    return {
        "message": event,
    }
