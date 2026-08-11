# ==========================================================
# Task 2: Tool-Calling Delivery Agent
# ==========================================================

# -----------------------------
# Tool Functions
# -----------------------------

def check_restaurant_status(name):
    return f"Restaurant '{name}' is currently Open and accepting orders."


def get_estimated_delivery_time(order_id):
    return f"Order {order_id} will be delivered in approximately 30 minutes."


def apply_discount(order_id, reason):
    return f"Discount of 20% applied to Order {order_id}. Reason: {reason}."


def file_complaint(order_id, issue):
    return f"Complaint registered for Order {order_id}. Issue: {issue}."


# -----------------------------
# FoodDeliveryAgent Class
# -----------------------------

class FoodDeliveryAgent:

    def __init__(self):
        self.log = []

    def think(self, query):

        query_lower = query.lower()

        # Restaurant Status
        if "restaurant" in query_lower or "open" in query_lower:

            result = check_restaurant_status("Food Paradise")
            tool = "check_restaurant_status"

        # Delivery Time
        elif "delivery" in query_lower or "time" in query_lower or "track" in query_lower:

            result = get_estimated_delivery_time("ORD101")
            tool = "get_estimated_delivery_time"

        # Discount
        elif "discount" in query_lower or "coupon" in query_lower or "offer" in query_lower:

            result = apply_discount("ORD101", "Customer Loyalty")
            tool = "apply_discount"

        # Complaint
        elif "complaint" in query_lower or "late" in query_lower or "issue" in query_lower:

            result = file_complaint("ORD101", "Late Delivery")
            tool = "file_complaint"

        else:

            result = "Sorry, I could not understand your request."
            tool = "None"

        self.log.append((query, tool, result))

        return result


# -----------------------------
# Testing the Agent
# -----------------------------

agent = FoodDeliveryAgent()

queries = [
    "Is the restaurant open?",
    "Track my delivery time.",
    "Can I get a discount on my order?",
    "I want to file a complaint about late delivery.",
    "Do you have any offers or coupons?"
]

print("========== TOOL OUTPUT ==========\n")

for q in queries:
    print("Query :", q)
    print("Response :", agent.think(q))
    print("-" * 60)

print("\n========== SESSION LOG ==========\n")

for i, entry in enumerate(agent.log, start=1):
    print(f"{i}.")
    print("Query       :", entry[0])
    print("Tool Called :", entry[1])
    print("Result      :", entry[2])
    print("-" * 60)