import json
from fastapi import FastAPI
from dotenv import load_dotenv
import os

load_dotenv()

SERVER_NAME = os.getenv("SERVER_NAME")


app = FastAPI()


@app.get("/")
async def check():
    return {"message": "Welcome to {}! Enjoy your stay.".format(SERVER_NAME)}
