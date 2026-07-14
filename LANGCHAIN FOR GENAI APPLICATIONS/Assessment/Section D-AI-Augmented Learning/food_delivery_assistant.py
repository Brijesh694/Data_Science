import re
from langchain_classic.memory import ConversationBufferMemory
from langchain_classic.chains import ConversationChain
from langchain_classic.llms.fake import FakeListLLM

orders = {
    "#101": "Preparing",
    "#102": "Out for delivery",
    "#103": "Delivered",
    "#104": "Cancelled"
}

memory = ConversationBufferMemory()

llm = FakeListLLM(
    responses=[
        "Let me check that order for you.",
    ] * 100
)

conversation = ConversationChain(
    llm=llm,
    memory=memory,
    verbose=False
)

queried_orders = set()
last_order = None

print("Food Delivery Order Tracking Assistant")
print("Type 'quit' to exit.\n")

while True:
    user_input = input("You: ")

    if user_input.lower() == "quit":
        break
    conversation.predict(input=user_input)

    match = re.search(r"#\d+", user_input)

    if match:
        order_id = match.group()
        last_order = order_id
    else:
        order_id = last_order

    if order_id:
        queried_orders.add(order_id)

        if order_id in orders:
            print(f"Assistant: Order {order_id} is currently '{orders[order_id]}'.")
        else:
            print(f"Assistant: Sorry, order {order_id} was not found.")
    else:
        print("Assistant: Please provide an order ID.")

print("\nSession Summary")
print(f"Unique orders queried: {len(queried_orders)}")

if queried_orders:
    print("Orders:", ", ".join(sorted(queried_orders)))