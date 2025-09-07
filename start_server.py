from fastapi import FastAPI
from pydantic import BaseModel
from langchain_huggingface import HuggingFaceEmbeddings
from src.config.config import CPU_OR_CUDA, EMBEDDING_MODEL_ID

# Init model
embeddings = HuggingFaceEmbeddings(
    model_name=EMBEDDING_MODEL_ID,
    model_kwargs={ "device": CPU_OR_CUDA },
    encode_kwargs={ "normalize_embeddings": True },
)

# FastAPI app
app = FastAPI(title="Embeddings Service")

class EmbedRequest(BaseModel):
    texts: list[str]

class EmbedResponse(BaseModel):
    vectors: list[list[float]]

@app.post("/embed", response_model=EmbedResponse)
def embed(req: EmbedRequest):
    vectors = embeddings.embed_documents(req.texts)
    return {"vectors": vectors}
