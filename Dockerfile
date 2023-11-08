FROM python:latest

WORKDIR /app

RUN apt-get update && apt-get install -y git

RUN git clone https://github.com/MikeDev101/cloudlink

RUN mv cloudlink/python/cloudlink /app
RUN mv cloudlink/python /app/
RUN mv /app/server_example.py /app/main.py

CMD ["python", "main.py"]