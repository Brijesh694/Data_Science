# ==========================================================
# Task 3: Memory-Aware Strategy Selector
# ==========================================================

# -----------------------------
# User Memory
# -----------------------------
memory = {}


# -----------------------------
# Strategy Functions
# -----------------------------
def prompt_template_response(query):
    return f"Prompt Template Response: Your request '{query}' has been received. We will assist you shortly."


def rag_lookup_response(query):
    return f"RAG Response: Retrieved the latest menu information related to '{query}'."


def fine_tuned_response(query):
    return f"Fine-Tuned Response: We are sorry for the inconvenience. Your complaint has been recorded and our support team will resolve it as soon as possible."


# -----------------------------
# Decide Strategy
# -----------------------------
def decide_strategy(user_id, query):

    # Create memory for new user
    if user_id not in memory:
        memory[user_id] = {
            "interaction_count": 0,
            "preferred_cuisine": None,
            "last_complaint": None
        }

    user = memory[user_id]

    # Update interaction count
    user["interaction_count"] += 1

    query_lower = query.lower()

    # Update preferred cuisine
    if "pizza" in query_lower:
        user["preferred_cuisine"] = "Italian"

    elif "burger" in query_lower:
        user["preferred_cuisine"] = "Fast Food"

    elif "paneer" in query_lower:
        user["preferred_cuisine"] = "Indian"

    # Strategy Selection

    # Complaint after 3+ interactions
    if (
        ("complaint" in query_lower or "late" in query_lower or "refund" in query_lower)
        and user["interaction_count"] >= 3
    ):

        strategy = "fine_tuned"
        response = fine_tuned_response(query)
        user["last_complaint"] = query

    # Menu or Item Queries
    elif (
        "menu" in query_lower
        or "pizza" in query_lower
        or "burger" in query_lower
        or "paneer" in query_lower
        or "item" in query_lower
    ):

        strategy = "rag_lookup"
        response = rag_lookup_response(query)

    # Default
    else:

        strategy = "prompt_template"
        response = prompt_template_response(query)

    return strategy, response


# -----------------------------
# Simulated Interactions
# -----------------------------
user_id = "USER101"

queries = [
    "Show me the pizza menu.",
    "What burger items are available?",
    "Track my order.",
    "My delivery is late.",
    "I want to file a complaint and request a refund."
]

print("=" * 65)
print("Memory-Aware Strategy Selector")
print("=" * 65)

for i, query in enumerate(queries, start=1):

    strategy, response = decide_strategy(user_id, query)

    print(f"\nInteraction {i}")
    print("Query     :", query)
    print("Strategy  :", strategy)
    print("Response  :", response)
    print("Memory    :", memory[user_id])