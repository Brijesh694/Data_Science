from sentence_transformers import SentenceTransformer
import faiss
import numpy as np

with open("refund_policy.txt", "r", encoding="utf-8") as file:
    policy_text = file.read()

chunk_size = 100

chunks = [
    policy_text[i:i + chunk_size]
    for i in range(0, len(policy_text), chunk_size)
]

print(f"\nLoaded {len(chunks)} chunks.\n")

model = SentenceTransformer("all-MiniLM-L6-v2")

embeddings = model.encode(chunks)

dimension = embeddings.shape[1]

index = faiss.IndexFlatL2(dimension)

index.add(np.array(embeddings).astype("float32"))

print("FAISS Index Created Successfully!\n")

while True:

    question = input("\nAsk a question (or type 'quit'): ")

    if question.lower() == "quit":
        print("Exiting program. Goodbye!")
        break

    query_embedding = model.encode([question])

    distances, indices = index.search(
        np.array(query_embedding).astype("float32"),
        k=2
    )

    retrieved_chunks = [chunks[i] for i in indices[0]]

    context = "\n\n".join(retrieved_chunks)

    rag_prompt = f"""
You are a Food Delivery Refund Assistant.

Context:
{context}

Question:
{question}

Answer based only on the context above.
"""
    print("\n" + "=" * 50)
    print("TOP 2 RETRIEVED CHUNKS")
    print("=" * 50)

    for i, chunk in enumerate(retrieved_chunks, start=1):
        print(f"\nChunk {i}:")
        print(chunk)

    print("\n" + "=" * 50)
    print("ASSEMBLED RAG PROMPT")
    print("=" * 50)
    print(rag_prompt)

    simulated_answer = (
        "Simulated Answer: Based on the retrieved policy "
        "information, the customer may be eligible for a refund."
    )

    print("\n" + "=" * 50)
    print("SIMULATED ANSWER")
    print("=" * 50)
    print(simulated_answer)