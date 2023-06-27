import json
from fastapi import FastAPI
from dotenv import load_dotenv
import os

load_dotenv()

JOB_STATUS_IN_QUEUE = "IN QUEUE"
BUCKET_NAME = os.getenv("BUCKET_NAME")


app = FastAPI()


@app.get("/")
async def check():
    return {"status": "It's on!"}
