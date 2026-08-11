# ============================================================
# Mini Capstone Project
# Agentic Food Delivery Assistant
# ============================================================

# ---------------------------
# Session Memory
# ---------------------------
session_memory = {
    "orders_placed": [],
    "complaints_filed": [],
    "preferred_cuisine": None,
    "interaction_count": 0
}

# ---------------------------
# Session Log
# ---------------------------
session_log = []

# ---------------------------
# Tool 1 : Place Order
# ---------------------------
def place_order():
    food = input("Enter food item: ")
    cuisine = input("Enter cuisine: ")

    order_id = f"ORD{100 + len(session_memory['orders_placed']) + 1}"

    session_memory["orders_placed"].append({
        "order_id": order_id,
        "food": food,
        "status": "Preparing"
    })

    session_memory["preferred_cuisine"] = cuisine

    return {
        "order_id": order_id,
        "food": food,
        "status": "Preparing"
    }


# ---------------------------
# Tool 2 : Track Order
# ---------------------------
def track_order():

    if not session_memory["orders_placed"]:
        return "No orders found."

    order_id = input("Enter Order ID: ")

    for order in session_memory["orders_placed"]:
        if order["order_id"] == order_id:
            return f"Order {order_id} is {order['status']}."

    return "Order not found."


# ---------------------------
# Tool 3 : File Complaint
# ---------------------------
def file_complaint():

    complaint = input("Enter your complaint: ")

    session_memory["complaints_filed"].append(complaint)

    return "Complaint registered successfully."


# ---------------------------
# Tool 4 : Recommendation
# ---------------------------
def get_recommendations():

    cuisine = session_memory["preferred_cuisine"]

    if cuisine is None:
        return "Recommendation: Pizza"

    recommendations = {
        "Indian": "Paneer Butter Masala",
        "Chinese": "Veg Hakka Noodles",
        "Italian": "Veg Alfredo Pasta",
        "Mexican": "Veg Burrito"
    }

    return recommendations.get(cuisine, "Veg Pizza")


# ---------------------------
# Decide AI Strategy
# ---------------------------
def decide_response_strategy(action_type, memory):

    if action_type == "recommend":
        if memory["preferred_cuisine"]:
            return "fine_tuned"
        return "prompt"

    elif action_type == "track":
        return "rag"

    elif action_type == "complaint":
        return "fine_tuned"

    return "prompt"


# ---------------------------
# Log Function
# ---------------------------
def log_action(action, arguments, result, strategy):

    session_log.append({
        "action": action,
        "arguments": arguments,
        "result": result,
        "strategy": strategy
    })


# ============================================================
# Main Program
# ============================================================

while True:

    print("\n========== Food Delivery Assistant ==========")
    print("1. Place Order")
    print("2. Track Order")
    print("3. File Complaint")
    print("4. Get Personalised Recommendations")
    print("5. Exit")

    choice = input("Enter choice: ")

    if choice == "1":

        strategy = decide_response_strategy("order", session_memory)

        result = place_order()

        session_memory["interaction_count"] += 1

        log_action(
            "Place Order",
            result["food"],
            result,
            strategy
        )

        print("\nStrategy :", strategy)
        print("Result :", result)

    elif choice == "2":

        strategy = decide_response_strategy("track", session_memory)

        order = input("Enter Order ID: ")

        found = False

        for item in session_memory["orders_placed"]:
            if item["order_id"] == order:
                result = f"Order {order} is {item['status']}."
                found = True
                break

        if not found:
            result = "Order not found."

        session_memory["interaction_count"] += 1

        log_action(
            "Track Order",
            order,
            result,
            strategy
        )

        print("\nStrategy :", strategy)
        print("Result :", result)

    elif choice == "3":

        strategy = decide_response_strategy("complaint", session_memory)

        complaint = input("Enter complaint: ")

        session_memory["complaints_filed"].append(complaint)

        result = "Complaint filed successfully."

        session_memory["interaction_count"] += 1

        log_action(
            "File Complaint",
            complaint,
            result,
            strategy
        )

        print("\nStrategy :", strategy)
        print("Result :", result)

    elif choice == "4":

        strategy = decide_response_strategy(
            "recommend",
            session_memory
        )

        result = get_recommendations()

        session_memory["interaction_count"] += 1

        log_action(
            "Recommendation",
            session_memory["preferred_cuisine"],
            result,
            strategy
        )

        print("\nStrategy :", strategy)
        print("Recommended Food :", result)

    elif choice == "5":

        print("\n========== SESSION REPORT ==========")

        for i, log in enumerate(session_log, start=1):

            print(f"\nAction {i}")
            print("Tool :", log["action"])
            print("Arguments :", log["arguments"])
            print("Strategy :", log["strategy"])
            print("Result :", log["result"])

        print("\n========== FINAL SESSION MEMORY ==========")

        print("Orders Placed :", session_memory["orders_placed"])
        print("Complaints Filed :", session_memory["complaints_filed"])
        print("Preferred Cuisine :", session_memory["preferred_cuisine"])
        print("Interaction Count :", session_memory["interaction_count"])

        print("\nThank You!")

        break

    else:
        print("Invalid Choice.")