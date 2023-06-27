# Use Python39
FROM python:3.10-slim
# Allow statements and log messages to immediately appear in the Knative logs
ENV PYTHONUNBUFFERED True

ENV PORT 8080

COPY requirements.txt .

RUN pip install --no-cache -r requirements.txt

COPY . .

EXPOSE ${PORT}

CMD exec uvicorn --log-level debug --port $PORT --host 0.0.0.0 --timeout-keep-alive 1800 app:app
