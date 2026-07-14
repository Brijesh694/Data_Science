from langchain_classic.memory import ConversationBufferMemory
from langchain_classic.prompts import PromptTemplate
from langchain_classic.chains import ConversationChain
from langchain_community.llms import Ollama

llm = Ollama(model="llama3")

memory = ConversationBufferMemory(
    memory_key="history",
    return_messages=False
)

template = """
You are QuickBite Food Delivery Assistant.

Your responsibilities:
- Help users with food recommendations.
- Remember the user's delivery address.
- Remember the user's dietary preferences.
- Use stored information in later replies.
- Be friendly and concise.

Conversation History:
{history}

Human: {input}

Assistant:
"""

prompt = PromptTemplate(
    input_variables=["history", "input"],
    template=template
)

conversation = ConversationChain(
    llm=llm,
    memory=memory,
    prompt=prompt,
    verbose=False
)

sample_messages = [
    "My delivery address is 123 Green Park, Ahmedabad.",
    "I am vegetarian.",
    "Recommend something for dinner.",
    "Will it be delivered to my address?",
    "What is the capital of France?"
]

print("\n===== SIMULATED CONVERSATION =====\n")

for msg in sample_messages:

    print(f"User: {msg}")

    response = conversation.predict(input=msg)

    print(f"QuickBite: {response}\n")

turn_count = 0

print("\n===== INTERACTIVE MODE =====")
print("Type 'exit' to quit.\n")

while True:

    user_input = input("User: ")

    if user_input.lower() == "exit":

        print("\nConversation Ended")
        print(f"Total Turns: {turn_count}")

        print("\n===== MEMORY BUFFER =====")
        print(memory.buffer)

        break

    response = conversation.predict(
        input=user_input
    )

    print(f"QuickBite: {response}\n")

    turn_count += 1