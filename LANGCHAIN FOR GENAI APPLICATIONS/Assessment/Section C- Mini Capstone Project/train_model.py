import pandas as pd
from sklearn.linear_model import LinearRegression
import joblib

data = pd.DataFrame({
    "distance_km": [1,2,3,4,5,6,7,8,9,10],
    "num_items": [1,2,1,3,2,4,3,5,4,6],
    "rain_flag": [0,0,1,0,1,0,1,0,1,0],
    "delivery_time": [15,20,28,25,35,30,40,38,45,42]
})

X = data[["distance_km","num_items","rain_flag"]]
y = data["delivery_time"]

model = LinearRegression()
model.fit(X, y)

joblib.dump(model, "delivery_model.joblib")

print("Model saved successfully.")