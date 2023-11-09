# How to Deploy OpenGPTs with Docker

I will demonstrate how to quickly deploy an OpenGPTs service using Docker and Docker Compose.

**1. Create a file named `Dockerfile` and fill it with the following content:**

```Dockerfile
FROM node:18 AS frontend
WORKDIR /frontend
COPY ./opengpts/frontend .
RUN npm i
RUN npm run build

FROM python:3.11-slim
WORKDIR /backend
COPY ./opengpts/backend .
RUN rm poetry.lock
RUN pip install .
COPY --from=frontend /frontend/dist ./ui
CMD exec uvicorn app.server:app --host 0.0.0.0 --port $PORT
```

Do not execute this Dockerfile directly through Docker for now.

**2. Create a file named `docker-compose.yml` and fill it with the following content:**

```yaml
version: "3"
services:
  server:
    build: 
      context: .
    environment:
      - PORT=8000
      - OPENAI_API_KEY=sk-...
    ports:
      - 8000:8000
```

Replace `OPENAI_API_KEY` with your own API key.

**3. Clone the OpenGPTs project from GitHub:**

Use the following command to clone the OpenGPTs project from GitHub:

```bash
git clone https://github.com/langchain-ai/opengpts
```

**4. Build the Docker image:**

Use the following command to build the Docker image:

```bash
docker-compose build
```

**5. Start the service:**

Use the following command to start the service:

```bash
docker-compose up -d
```

Now, you can access the deployed service interface through your browser at `http://localhost:8000/`. If deployed remotely, replace localhost with the corresponding IP address.


For more content, please visit: [https://www.freegpttools.org/opengpts](https://www.freegpttools.org/opengpts)