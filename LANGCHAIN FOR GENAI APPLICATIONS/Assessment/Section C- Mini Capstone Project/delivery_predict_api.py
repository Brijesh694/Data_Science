from flask import Flask, request, jsonify
import joblib

app = Flask(__name__)

model = joblib.load("delivery_model.joblib")

@app.route("/")
def home():
    return "QuickBite Delivery Prediction API is Running!"

@app.route("/predict", methods=["POST"])
def predict():
    data = request.get_json()

    distance = float(data["distance_km"])
    items = int(data["num_items"])
    rain = int(data["rain_flag"])

    prediction = model.predict([[distance, items, rain]])[0]

    return jsonify({
        "delivery_time": round(float(prediction), 2)
    })

if __name__ == "__main__":
    app.run(debug=True)