FROM python:3.13-alpine

RUN apk add curl

WORKDIR /app
COPY ./requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /app/requirements.txt
COPY ./app.py /app/app.py

HEALTHCHECK --interval=10s --timeout=5s --start-period=10s CMD curl --fail http://localhost/ping || exit 1
CMD ["fastapi", "run", "/app/app.py", "--port", "80"]