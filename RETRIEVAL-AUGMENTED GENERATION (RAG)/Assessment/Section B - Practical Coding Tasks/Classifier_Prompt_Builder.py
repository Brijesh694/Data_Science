examples = [
    {
        "input": "My order arrived 90 minutes late.",
        "output": "Late Delivery"
    },
    {
        "input": "I received a burger instead of the pizza I ordered.",
        "output": "Wrong Item"
    },
    {
        "input": "The drink I paid for was missing from my order.",
        "output": "Missing Item"
    },
    {
        "input": "The food was cold and tasted stale.",
        "output": "Poor Quality"
    }
]


def add_example(text, label):
    examples.append({
        "input": text,
        "output": label
    })


def build_few_shot_prompt(complaint_text):

    prompt = """
You are a complaint classification assistant.

Classify each complaint into one of the following categories:
- Late Delivery
- Wrong Item
- Missing Item
- Poor Quality

Examples:

"""

    for example in examples:
        prompt += f"Input: {example['input']}\n"
        prompt += f"Output: {example['output']}\n\n"

    prompt += f"Input: {complaint_text}\n"
    prompt += "Output:"

    return prompt

print("=" * 60)
print("PROMPT 1")
print("=" * 60)

complaint1 = "My food arrived almost two hours late."

print(build_few_shot_prompt(complaint1))


add_example(
    "The dessert was not included in my delivery.",
    "Missing Item"
)

print("\n" + "=" * 60)
print("PROMPT 2 (AFTER ADDING NEW EXAMPLE)")
print("=" * 60)

complaint2 = "The meal was spoiled and smelled bad."

print(build_few_shot_prompt(complaint2))