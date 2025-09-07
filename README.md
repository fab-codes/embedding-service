# Embeddings Service with FastAPI and Docker

## Description

This project provides an HTTP service to generate text embeddings using HuggingFace models. The API is built with FastAPI and containerized with Docker, ready to use locally or in test/prototype environments.

## Features

- `/embed` endpoint that accepts a list of texts and returns embedding vectors.
- Model and device configurable via environment variables.
- Docker image includes the model pre-downloaded for immediate startup.
- Gunicorn + Uvicorn used to handle multiple concurrent requests.

## Environment Variables

- `EMBEDDING_MODEL_ID`: HuggingFace model ID to use (default: `sentence-transformers/all-MiniLM-L6-v2`).
- `DEVICE`: Set to `cpu` or `cuda` depending on available hardware (default: `cpu`).

## Docker Usage

1. Build the image:

```
docker build -t embeddings-service .
```

2. Run the container with defaults:

```
docker run -p 8000:8000 embeddings-service
```

3. Override environment variables if needed:

```
docker run -e EMBEDDING_MODEL_ID=Qwen/Qwen3-Embedding-0.6B -e DEVICE=cuda -p 8000:8000 embeddings-service
```

## Docker Compose Example

```yaml
services:
  embeddings:
    image: embeddings-service:latest
    ports:
      - "8000:8000"
    environment:
      EMBEDDING_MODEL_ID: sentence-transformers/all-MiniLM-L6-v2
      DEVICE: cpu
```

## API

**POST** `/embed`

Request JSON:

```json
{ "texts": ["text1", "text2"] }
```

Response JSON:

```json
{ "vectors": [[...], [...]] }
```

## Notes

- The model is pre-downloaded during the build, so first startup is fast.
- If a GPU is available, set `DEVICE=cuda` to utilize it.
- Larger models require more RAM and longer initialization time.
