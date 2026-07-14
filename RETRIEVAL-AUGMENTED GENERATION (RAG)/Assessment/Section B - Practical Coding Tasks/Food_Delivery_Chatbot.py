SYSTEM_PROMPT = """
You are a Food Delivery Customer Support Agent.
Maintain a professional, polite, and helpful tone.
Provide accurate assistance to customers.
Responses must not exceed 80 words.
"""
def validate_issue(issue_type):
    allowed_issues = [
        "late delivery",
        "missing item",
        "wrong item"
    ]

    if issue_type.lower() not in allowed_issues:
        raise ValueError(
            f"Invalid issue_type '{issue_type}'. "
            f"Allowed values are: {', '.join(allowed_issues)}"
        )

def build_prompt(customer_name, order_id, issue_type):

    validate_issue(issue_type)

    user_prompt = f"""
Customer Name: {customer_name}
Order ID: {order_id}
Issue Type: {issue_type}

Please assist the customer with their issue.
"""

    return SYSTEM_PROMPT, user_prompt


test_cases = [
    ("Brijesh", "ORD101", "late delivery"),
    ("Rahul", "ORD102", "missing item"),
    ("Priya", "ORD103", "damaged item")   # Invalid Case
]

for customer_name, order_id, issue_type in test_cases:

    print("\n" + "=" * 60)

    try:
        system_prompt, user_prompt = build_prompt(
            customer_name,
            order_id,
            issue_type
        )

        print("SYSTEM PROMPT:")
        print(system_prompt)

        print("USER PROMPT:")
        print(user_prompt)

    except ValueError as e:
        print("Error:", e)