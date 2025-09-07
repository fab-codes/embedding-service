from dotenv import load_dotenv
import os

load_dotenv()

# EMBEDDING
EMBEDDING_MODEL_ID = os.getenv("EMBEDDING_MODEL_ID")
CPU_OR_CUDA= os.getenv("CPU_OR_CUDA")