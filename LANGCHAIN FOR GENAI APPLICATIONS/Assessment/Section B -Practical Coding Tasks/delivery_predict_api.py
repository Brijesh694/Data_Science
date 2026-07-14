from flask import Flask, request, jsonify
import pandas as pd
import joblib

app = Flask(__name__)

model = joblib.load("delivery_model.joblib")

print("Model loaded successfully!")

@app.route("/")
def home():
    return jsonify({
        "message": "Delivery Time Prediction API is running."
    })

@app.route("/predict", methods=["POST"])
def predict():

    data = request.get_json()

    required_fields = ["distance_km", "num_items", "rain_flag"]

  
    missing_fields = [
        field for field in required_fields
        if field not in data
    ]

    if missing_fields:
        return jsonify({
            "error": "Missing required fields",
            "missing_fields": missing_fields
        }), 400

    try:
        input_data = pd.DataFrame({
            "distance_km": [data["distance_km"]],
            "num_items": [data["num_items"]],
            "rain_flag": [data["rain_flag"]]
        })

        prediction = model.predict(input_data)[0]

        return jsonify({
            "predicted_delivery_time_min": round(float(prediction), 1)
        }), 200

    except Exception as e:
        return jsonify({
            "error": str(e)
        }), 400


if __name__ == "__main__":
    app.run(debug=True)