import streamlit as st
import json
import requests
from langchain_classic.memory import ConversationBufferMemory

st.set_page_config(page_title="QuickBite AI")

st.title("QuickBite AI")

if "memory" not in st.session_state:
    st.session_state.memory = ConversationBufferMemory()

if "messages" not in st.session_state:
    st.session_state.messages = []

st.sidebar.header("User Preferences")

address = st.sidebar.text_input("Delivery Address")

diet = st.sidebar.selectbox(
    "Dietary Preference",
    ["Veg", "Non-Veg"]
)

if st.sidebar.button("Clear Chat"):
    st.session_state.messages = []
    st.session_state.memory.clear()
    st.rerun()

with open("menu_items.json", "r") as f:
    menu = json.load(f)

def get_delivery_estimate(distance, items, weather):

    try:
        response = requests.post(
            "http://127.0.0.1:5000/predict",
            json={
                "distance_km": distance,
                "num_items": items,
                "rain_flag": weather
            }
        )

        result = response.json()

        return f"Estimated delivery time: {result['delivery_time']} minutes"

    except:
        return "Prediction API is not running."

def search_menu(query):

    filtered = menu

    if diet == "Veg":
        filtered = [x for x in filtered if x["veg"]]

    cuisine = None

    for item in menu:
        if item["cuisine"].lower() in query.lower():
            cuisine = item["cuisine"]

    if cuisine:
        filtered = [
            x for x in filtered
            if x["cuisine"] == cuisine
        ]

    return filtered[:3]

for role, message in st.session_state.messages:
    with st.chat_message(role):
        st.write(message)

prompt = st.chat_input("Ask QuickBite AI")

if prompt:

    st.session_state.messages.append(
        ("user", prompt)
    )

    lower = prompt.lower()

    if "delivery" in lower or "how long" in lower:

        reply = get_delivery_estimate(
            distance=5,
            items=2,
            weather=0
        )

    elif "recommend" in lower:

        foods = search_menu(prompt)

        if foods:

            reply = "Recommended Items:\n\n"

            for food in foods:
                reply += (
                    f"• {food['name']} "
                    f"({food['cuisine']}) "
                    f"₹{food['price']}\n"
                )

        else:
            reply = "No matching menu items found."

    else:

        reply = (
            f"Address: {address}\n"
            f"Diet: {diet}\n\n"
            f"How can I help you today?"
        )

    st.session_state.messages.append(
        ("assistant", reply)
    )

    st.rerun()