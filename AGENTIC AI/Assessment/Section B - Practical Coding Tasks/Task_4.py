# ==========================================================
# Task 4: Multi-Agent Order Lifecycle System
# ==========================================================

import random
import time


# ----------------------------------------------------------
# Agent 1 : OrderAgent
# ----------------------------------------------------------
class OrderAgent:

    def process(self, customer_input):

        order_summary = {
            "customer": customer_input["customer"],
            "food_item": customer_input["food_item"],
            "quantity": customer_input["quantity"],
            "restaurant": customer_input["restaurant"],
            "order_id": f"ORD{random.randint(1000,9999)}"
        }

        return order_summary


# ----------------------------------------------------------
# Agent 2 : DispatchAgent
# ----------------------------------------------------------
class DispatchAgent:

    partners = ["Rahul", "Amit", "Priya", "Karan"]

    def process(self, order_summary):

        dispatch_details = {
            "delivery_partner": random.choice(self.partners),
            "eta": f"{random.randint(20,45)} minutes"
        }

        return dispatch_details


# ----------------------------------------------------------
# Agent 3 : SupportAgent
# ----------------------------------------------------------
class SupportAgent:

    def process(self, feedback):

        feedback = feedback.lower()

        # Positive Feedback
        if "good" in feedback or "excellent" in feedback or "happy" in feedback:

            classification = "positive"
            technique = "prompt"

        # Complaint
        elif "late" in feedback or "cold" in feedback or "complaint" in feedback:

            classification = "complaint"
            technique = "fine-tuned"

        # Escalation
        else:

            classification = "escalate"
            technique = "RAG"

        return {
            "classification": classification,
            "technique": technique
        }


# ----------------------------------------------------------
# Coordinator
# ----------------------------------------------------------
class Coordinator:

    def __init__(self):

        self.order_agent = OrderAgent()
        self.dispatch_agent = DispatchAgent()
        self.support_agent = SupportAgent()

    def run_lifecycle(self, customer_input, feedback):

        start = time.time()

        # Step 1
        order = self.order_agent.process(customer_input)

        # Step 2
        dispatch = self.dispatch_agent.process(order)

        # Step 3
        support = self.support_agent.process(feedback)

        end = time.time()

        print("\n" + "=" * 60)
        print("FOOD DELIVERY LIFECYCLE REPORT")
        print("=" * 60)

        print("\nOrder Summary")
        print(order)

        print("\nDispatch Details")
        print(dispatch)

        print("\nFeedback")
        print(feedback)

        print("\nClassification")
        print(support["classification"])

        print("\nTechnique Selected")
        print(support["technique"])

        print("\nTotal Processing Time")
        print(f"{end-start:.4f} seconds")

        print("=" * 60)


# ==========================================================
# Main Program
# ==========================================================

coordinator = Coordinator()

# ----------------------------------------------------------
# Scenario 1 : Smooth Delivery
# ----------------------------------------------------------
customer1 = {
    "customer": "Brijesh",
    "food_item": "Veg Pizza",
    "quantity": 2,
    "restaurant": "Pizza Hub"
}

feedback1 = "Good service and excellent delivery."

coordinator.run_lifecycle(customer1, feedback1)


# ----------------------------------------------------------
# Scenario 2 : Complaint
# ----------------------------------------------------------
customer2 = {
    "customer": "Rahul",
    "food_item": "Paneer Biryani",
    "quantity": 1,
    "restaurant": "Spice Garden"
}

feedback2 = "Food was late and cold. I want to file a complaint."

coordinator.run_lifecycle(customer2, feedback2)