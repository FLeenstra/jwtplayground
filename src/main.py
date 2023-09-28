from fastapi import FastAPI
import redis
import jwt #pyJWt
import os
from datetime import timedelta
from pydantic import BaseModel

app = FastAPI()

class Login(BaseModel):
    username: str
    password: str



jwtSecret = os.environ["jwtSecret"]
redisServer = os.environ["redis_server_address"]
redisPort = os.environ["redis_server_port"]
r = redis.Redis(host=redisServer, port=redisPort, db=0)
r.set('foo', 'bar')

@app.post("/authenticate/")
def read_root(login: Login):
    encoded_jwt = jwt.encode({"some": "payload"}, jwtSecret, algorithm="HS256")
    r.set(encoded_jwt, 'foo')
    return {encoded_jwt}
