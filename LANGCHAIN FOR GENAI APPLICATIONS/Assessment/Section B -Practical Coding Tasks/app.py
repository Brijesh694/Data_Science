import streamlit as st
import requests

st.set_page_config(
    page_title="Dish Description Generator",
    page_icon="🍽️",
    layout="centered"
)

OLLAMA_URL = "http://localhost:11434/api/generate"
MODEL_NAME = "gemma3"   


def generate_description(dish_name, cuisine_type, length_pref):

    prompt = f"""
You are a food marketing expert.

Dish Name: {dish_name}
Cuisine Type: {cuisine_type}
Description Length: {length_pref}

Instructions:
- Write an appetising promotional description.
- Use a customer-facing tone.
- Highlight flavour, aroma, texture, and freshness.
- Make it suitable for a food delivery app.

Length Guide:
- Short: 30-50 words
- Medium: 60-100 words
- Long: 120-180 words
"""
    print(prompt)
    

    response = requests.post(
        OLLAMA_URL,
        json={
            "model": MODEL_NAME,
            "prompt": prompt,
            "stream": False
        }
    )

    return response.json()["response"]


st.title(" LLM-Powered Dish Description Generator")

dish_name = st.text_input(
    "Dish Name",
    placeholder="Paneer Tikka Masala"
)

cuisine_type = st.text_input(
    "Cuisine Type",
    placeholder="North Indian"
)

length_pref = st.selectbox(
    "Description Length",
    ["Short", "Medium", "Long"]
)

if "generated_text" not in st.session_state:
    st.session_state.generated_text = ""

if "last_inputs" not in st.session_state:
    st.session_state.last_inputs = None


generate_btn = st.button("Generate Description")

if generate_btn:

    if dish_name and cuisine_type:

        st.session_state.last_inputs = (
            dish_name,
            cuisine_type,
            length_pref
        )

        with st.spinner("Generating description…"):

            result = generate_description(
                dish_name,
                cuisine_type,
                length_pref
            )

            st.session_state.generated_text = result

    else:
        st.warning("Please enter Dish Name and Cuisine Type.")


if st.session_state.generated_text:

    with st.container():

        st.markdown("### Generated Description")

        st.success(st.session_state.generated_text)

        st.write(
            f"Character Count: {len(st.session_state.generated_text)}"
        )

    if st.button("Regenerate"):

        if st.session_state.last_inputs:

            d, c, l = st.session_state.last_inputs

            with st.spinner("Generating description…"):

                result = generate_description(
                    d,
                    c,
                    l
                )

                st.session_state.generated_text = result

            st.rerun()