FROM python:3.13-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

RUN python -c "import os; \
    from langchain_huggingface import HuggingFaceEmbeddings; \
    model_id = os.getenv('EMBEDDING_MODEL_ID', 'sentence-transformers/all-MiniLM-L6-v2'); \
    device = os.getenv('DEVICE', 'cpu'); \
    HuggingFaceEmbeddings(model_name=model_id)"

COPY . .

EXPOSE 8000

ENV EMBEDDING_MODEL_ID=sentence-transformers/all-MiniLM-L6-v2 \
    DEVICE=cpu

CMD ["gunicorn", "-k", "uvicorn.workers.UvicornWorker", "start_server:app", "--bind", "0.0.0.0:8000", "--workers", "2"]