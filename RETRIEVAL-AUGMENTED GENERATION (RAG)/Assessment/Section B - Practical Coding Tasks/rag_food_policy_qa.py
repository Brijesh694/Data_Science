from sentence_transformers import SentenceTransformer
import faiss
import numpy as np

policy_text = """
Food Delivery Policy

Refund Policy

Customers may request a refund if items are missing, damaged, incorrect,
or if the restaurant cancels the order. Refund requests should be submitted
within 24 hours of delivery. Supporting evidence such as photographs may
be requested. Full refunds are generally provided when the restaurant is
unable to fulfill an order. Partial refunds may be granted for missing
items, damaged products, or quality-related concerns.

Refunds are reviewed by the customer support team. Once approved, refunds
are usually processed within 5 to 7 business days. Refund requests that
are determined to be fraudulent may be rejected. Repeated abuse of the
refund process may result in account suspension.

Delivery Policy

The platform aims to deliver orders within the estimated delivery window
displayed at checkout. Delivery times may vary due to weather conditions,
traffic congestion, restaurant workload, or other unforeseen circumstances.
Customers should ensure that their delivery address and contact information
are accurate.

If a driver is unable to contact the customer after multiple attempts,
the order may be marked as undeliverable. Delays caused by force majeure
events may not qualify for compensation. Customers should report delivery
issues as soon as possible.

Cancellation Policy

Customers may cancel orders before the restaurant begins preparing the
food. Once preparation has started, cancellation may not be available.
If the restaurant cancels an order for any reason, customers will receive
a full refund automatically.

Special promotional orders may be subject to different cancellation rules.
The platform reserves the right to review cancellation requests and may
take action against accounts that repeatedly abuse cancellation policies.
"""

words = policy_text.split()

chunk_size = 100
overlap = 20

chunks = []

for i in range(0, len(words), chunk_size - overlap):
    chunk = " ".join(words[i:i + chunk_size])

    if chunk:
        chunks.append(chunk)

print(f"\nTotal Chunks Created: {len(chunks)}")

print("\nLoading model...")

model = SentenceTransformer("all-MiniLM-L6-v2")

embeddings = model.encode(chunks)

embeddings = np.array(
    embeddings,
    dtype="float32"
)

dimension = embeddings.shape[1]

index = faiss.IndexFlatL2(dimension)

index.add(embeddings)

print("FAISS Index Created Successfully!")


def retrieve(query, k=3):

    query_embedding = model.encode([query])

    query_embedding = np.array(
        query_embedding,
        dtype="float32"
    )

    distances, indices = index.search(
        query_embedding,
        k
    )

    retrieved_chunks = []

    for idx in indices[0]:
        retrieved_chunks.append(chunks[idx])

    return retrieved_chunks


def build_rag_prompt(query, retrieved_chunks):

    prompt = """
SYSTEM ROLE:
You are a Food Delivery Policy Assistant.

Use only the provided context to answer questions.

"""

    for i, chunk in enumerate(retrieved_chunks, start=1):
        prompt += f"\nCONTEXT {i}:\n{chunk}\n"

    prompt += f"""

USER QUESTION:
{query}

INSTRUCTIONS:
Answer only from the provided context.
If the answer is not present in the context,
reply with: I don't know.

ANSWER:
"""

    return prompt

question = "What is the refund policy for missing items?"

retrieved_chunks = retrieve(question, k=3)

print("\n" + "=" * 60)
print("RETRIEVED CHUNKS")
print("=" * 60)

for i, chunk in enumerate(retrieved_chunks, start=1):
    print(f"\nChunk {i}:")
    print(chunk)

rag_prompt = build_rag_prompt(
    question,
    retrieved_chunks
)

print("\n" + "=" * 60)
print("ASSEMBLED RAG PROMPT")
print("=" * 60)

print(rag_prompt)
simulated_answer = """
Customers may request a refund for missing items within
24 hours of delivery. Partial refunds may be granted
for missing items after review by the support team.
"""

print("\n" + "=" * 60)
print("SIMULATED ANSWER")
print("=" * 60)

print(simulated_answer)