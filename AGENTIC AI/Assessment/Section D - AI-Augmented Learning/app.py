# ==========================================================
# Simplified ReAct Agent - Food Delivery Customer Support
# ==========================================================

# -------------------------------
# Mock Database
# -------------------------------
orders = {
    "ORD101": {
        "status": "Delivered 90 minutes late",
        "delivered": True,
        "delay": 90,
        "refund": True
    },
    "ORD102": {
        "status": "Preparing",
        "delivered": False,
        "delay": 0,
        "refund": False
    },
    "ORD103": {
        "status": "Cancelled",
        "delivered": False,
        "delay": 0,
        "refund": True
    }
}


# -------------------------------
# Tool 1
# -------------------------------
def lookup_order_status(order_id):
    """Returns order status."""
    if order_id not in orders:
        return {
            "success": False,
            "message": "Order not found."
        }

    order = orders[order_id]

    return {
        "success": True,
        "status": order["status"],
        "delay": order["delay"]
    }


# -------------------------------
# Tool 2
# -------------------------------
def check_refund_eligibility(order_id):
    """Checks refund eligibility."""

    if order_id not in orders:
        return {
            "success": False,
            "message": "Order not found."
        }

    order = orders[order_id]

    if order["refund"]:
        return {
            "success": True,
            "eligible": True,
            "reason": "Eligible for refund."
        }

    return {
        "success": True,
        "eligible": False,
        "reason": "Refund not available."
    }


# -------------------------------
# ReAct Agent
# -------------------------------
def react_agent(order_id, complaint):

    print("=" * 60)
    print("Food Delivery Customer Support Agent")
    print("=" * 60)

    print(f"\nUser Complaint:")
    print(f'"{complaint}"')

    # ---------------- Cycle 1 ----------------
    print("\n")
    print("----------- Cycle 1 -----------")

    thought = "I should first check whether the order exists and inspect its delivery status."
    print("Reason:")
    print(thought)

    print("\nAction:")
    print(f"lookup_order_status('{order_id}')")

    observation = lookup_order_status(order_id)

    print("\nObservation:")
    print(observation)

    # Handle error
    if not observation["success"]:

        print("\n----------- Cycle 2 -----------")

        thought = (
            "The order was not found. "
            "Instead of checking refund eligibility, I should ask the customer "
            "to verify the order ID."
        )

        print("Reason:")
        print(thought)

        print("\nAction:")
        print("No further tool call needed.")

        print("\nObservation:")
        print("Cannot continue because the order does not exist.")

        print("\nFinal Response:")
        print(
            "Sorry, I couldn't locate your order. "
            "Please check the order ID and try again."
        )

        return

    # ---------------- Cycle 2 ----------------
    print("\n")
    print("----------- Cycle 2 -----------")

    thought = (
        "The order exists. Now I should verify whether the customer "
        "is eligible for a refund."
    )

    print("Reason:")
    print(thought)

    print("\nAction:")
    print(f"check_refund_eligibility('{order_id}')")

    observation2 = check_refund_eligibility(order_id)

    print("\nObservation:")
    print(observation2)

    # ---------------- Final Response ----------------
    print("\n")
    print("=" * 60)
    print("Final Response")
    print("=" * 60)

    if observation2["eligible"]:
        print(
            f"Your order status is: {orders[order_id]['status']}.\n"
            "You are eligible for a refund.\n"
            "Our support team will process it shortly."
        )
    else:
        print(
            f"Your order status is: {orders[order_id]['status']}.\n"
            "Currently, your order is not eligible for a refund."
        )


# -------------------------------
# Example 1
# -------------------------------
react_agent(
    "ORD101",
    "My food arrived very late. I want a refund."
)

print("\n\n")

# -------------------------------
# Example 2 (Error Handling)
# -------------------------------
react_agent(
    "ORD999",
    "Where is my order?"
)