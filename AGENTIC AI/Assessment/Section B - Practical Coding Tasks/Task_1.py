# ==========================================================
# Task 1: AI Technique Decision Engine
# ==========================================================

def recommend_technique(update_frequency,
                        data_in_external_docs,
                        needs_custom_behaviour,
                        latency_budget):

    # Rule 1
    if data_in_external_docs == "yes" and update_frequency == "high":
        technique = "RAG"
        justification = (
            "The information changes frequently and is stored in external documents. "
            "RAG retrieves the latest data without retraining the model."
        )

    # Rule 2
    elif needs_custom_behaviour == "yes" and latency_budget == "low":
        technique = "Fine-Tuning"
        justification = (
            "The application requires specialized behaviour with fast responses. "
            "Fine-tuning learns the required behaviour and reduces repeated prompting."
        )

    # Rule 3
    elif needs_custom_behaviour == "yes":
        technique = "Fine-Tuning"
        justification = (
            "The system needs domain-specific behaviour. "
            "Fine-tuning provides more accurate and consistent outputs."
        )

    # Rule 4
    elif data_in_external_docs == "yes":
        technique = "RAG"
        justification = (
            "The required information is stored in external documents. "
            "RAG retrieves relevant information during inference."
        )

    # Rule 5
    else:
        technique = "Prompt Engineering"
        justification = (
            "The task does not require external knowledge or custom training. "
            "Prompt engineering is simple, flexible, and cost-effective."
        )

    return {
        "technique": technique,
        "justification": justification
    }


# ==========================================================
# Test Scenarios
# ==========================================================

scenarios = [
    (
        "Real-Time Menu Recommendations",
        "high", "yes", "no", "high"
    ),
    (
        "Complaint Categorisation",
        "low", "no", "yes", "low"
    ),
    (
        "Order Confirmation Message Generation",
        "low", "no", "no", "high"
    ),
    (
        "Domain-Specific FAQ Answering",
        "high", "yes", "yes", "high"
    )
]

# ==========================================================
# Execute
# ==========================================================

for name, update, docs, custom, latency in scenarios:

    result = recommend_technique(
        update,
        docs,
        custom,
        latency
    )

    print("=" * 60)
    print("Scenario :", name)
    print("Recommended Technique :", result["technique"])
    print("Justification :", result["justification"])