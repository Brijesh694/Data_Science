# Task 3: Semantic Search Over Restaurant FAQs

from sentence_transformers import SentenceTransformer
import faiss
import numpy as np

faqs = [
    "Delivery usually takes between 30 and 45 minutes depending on location.",
    "Orders can be cancelled before the restaurant starts preparing the food.",
    "Customers may request a refund for missing, damaged, or incorrect items.",
    "If an item is unavailable, the restaurant may offer a substitute item.",
    "Contact customer support through the app or website help center.",
    "Refunds are typically processed within 5 to 7 business days."
]


print("Loading model...")

model = SentenceTransformer("all-MiniLM-L6-v2")



faq_embeddings = model.encode(faqs)

faq_embeddings = np.array(
    faq_embeddings,
    dtype="float32"
)


dimension = faq_embeddings.shape[1]

index = faiss.IndexFlatL2(dimension)

index.add(faq_embeddings)

print(f"\nNumber of FAQs : {len(faqs)}")
print(f"Index Size     : {index.ntotal}")

# Verify index size
assert index.ntotal == len(faqs)

print("FAISS index created successfully.\n")


def search_faq(query, k=2):

    query_embedding = model.encode([query])

    query_embedding = np.array(
        query_embedding,
        dtype="float32"
    )

    distances, indices = index.search(
        query_embedding,
        k
    )

    results = []

    for idx, distance in zip(indices[0], distances[0]):
        results.append(
            (faqs[idx], float(distance))
        )

    return results


query1 = "How do I get my money back?"

print("=" * 60)
print("QUERY:", query1)
print("=" * 60)

results = search_faq(query1)

for i, (faq, distance) in enumerate(results, start=1):
    print(f"\nRank {i}")
    print("FAQ      :", faq)
    print("Distance :", round(distance, 4))


query2 = "Who should I talk to if I need help?"

print("\n" + "=" * 60)
print("QUERY:", query2)
print("=" * 60)

results = search_faq(query2)

for i, (faq, distance) in enumerate(results, start=1):
    print(f"\nRank {i}")
    print("FAQ      :", faq)
    print("Distance :", round(distance, 4))