FROM python:3.13-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

ENV EMBEDDING_MODEL_ID=Qwen/Qwen3-Embedding-0.6B \
    CPU_OR_CUDA=cpu

CMD ["uvicorn", "start_server:app", "--host", "0.0.0.0", "--port", "8000"]