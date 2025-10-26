# backend.py
from flask import Flask, jsonify, request, Response
import requests
import os
from dotenv import load_dotenv
from flask_cors import CORS



# Load .env
load_dotenv()

app = Flask(__name__)
CORS(app)  # enable CORS for all routes
API_KEY = os.environ.get("SPOONACULAR_API_KEY")

if not API_KEY:
    raise ValueError("Please set SPOONACULAR_API_KEY in your .env file")


@app.route("/recipes")
def get_recipes():
    url = (
        f"https://api.spoonacular.com/recipes/complexSearch"
        f"?diet=vegetarian&number=10&addRecipeInformation=true&apiKey={API_KEY}"
    )
    try:
        response = requests.get(url)
        response.raise_for_status()
        return jsonify(response.json())
    except requests.exceptions.RequestException as e:
        return jsonify({"error": str(e)}), 500


@app.route("/image")
def get_image():
    # Get the image URL from query parameter
    img_url = request.args.get("url")
    if not img_url:
        return jsonify({"error": "No URL provided"}), 400

    try:
        resp = requests.get(img_url, stream=True)
        resp.raise_for_status()
        # Return the image content with correct headers
        return Response(
            resp.content,
            content_type=resp.headers.get("Content-Type", "image/jpeg")
        )
    except requests.exceptions.RequestException as e:
        return jsonify({"error": str(e)}), 500


if __name__ == "__main__":
    app.run(debug=True)
