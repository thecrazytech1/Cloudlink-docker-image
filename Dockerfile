FROM python:latest

WORKDIR /app

RUN apt-get update && apt-get install -y git

RUN git clone https://github.com/MikeDev101/cloudlink

RUN mv cloudlink/python/cloudlink /app

RUN echo "from cloudlink import server\n" \ 
         "from cloudlink.server.protocols import clpv4\n" \ 
         "import os\n" \ 
         "def __init__(self):\n" \ 
         "pass\n"\
         "async def on_close(self, client):\n" \
         "print(\"Client\", client.id, \"disconnected.\")\n" \ 
         "async def on_connect(self, client):\n" \    
         "print(\"Client\", client.id, \"connected.\")\n" \
         "if __name__ == \"__main__\":" \   
         "server = server()\n" \ 
         "clpv4 = clpv4(server)\n" \ 
         "server.logging.basicConfig(\n" \
         "level=server.logging.DEBUG\n" \ 
         ")\n" \
         "events = events()\n" \ 
         "server.bind_event(server.on_connect, events.on_connect)\n" \
         "port = int(os.getenv("PORT", 3000))\n" \ 
         "server.run(\n" \ 
         "ip="0.0.0.0",\n" \
         "port=port\n " \ 
         ")" > main.py

CMD ["python", "main.py"]