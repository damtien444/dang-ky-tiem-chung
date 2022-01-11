import json
from datetime import datetime

from bson.objectid import ObjectId


class MyEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, ObjectId):
            return str(obj)
        if isinstance(obj, datetime):
            return obj.isoformat()
        return super(MyEncoder, self).default(obj)


