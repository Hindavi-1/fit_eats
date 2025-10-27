# # backend.py
# from flask import Flask, jsonify, request, Response
# import requests
# import os
# from dotenv import load_dotenv
# from flask_cors import CORS
#
# # Load environment variables
# load_dotenv()
#
# app = Flask(__name__)
# CORS(app)
# API_KEY = os.environ.get("SPOONACULAR_API_KEY")
#
# if not API_KEY:
#     raise ValueError("Please set SPOONACULAR_API_KEY in your .env file")
#
#
# def fetch_from_spoonacular(url):
#     try:
#         resp = requests.get(url)
#         resp.raise_for_status()
#         return resp.json()
#     except requests.exceptions.RequestException as e:
#         return {"error": str(e)}
#
#
# @app.route("/recipes")
# def get_recipes():
#     # Read query parameters
#     diet = request.args.get("diet", "vegetarian")
#     number = request.args.get("number", 10)
#
#     url = (
#         f"https://api.spoonacular.com/recipes/complexSearch"
#         f"?diet={diet}&number={number}&addRecipeInformation=true&apiKey={API_KEY}"
#     )
#     try:
#         response = requests.get(url)
#         response.raise_for_status()
#         data = response.json()
#         recipes = []
#
#         for r in data.get("results", []):
#             recipes.append({
#                 "id": r.get("id"),
#                 "title": r.get("title"),
#                 "image": r.get("image"),
#                 "readyInMinutes": r.get("readyInMinutes"),
#                 "servings": r.get("servings"),
#                 "calories": next(
#                     (n["amount"] for n in r.get("nutrition", {}).get("nutrients", []) if n["name"]=="Calories"),
#                     "N/A"
#                 ),
#                 "ingredients": [i.get("original") for i in r.get("extendedIngredients", [])],
#                 "instructions": r.get("instructions") or "No instructions available."
#             })
#
#         return jsonify({"recipes": recipes})
#
#     except requests.exceptions.RequestException as e:
#         return jsonify({"error": str(e)}), 500
#
#
# @app.route("/recipe/<int:recipe_id>")
# def get_recipe_detail(recipe_id):
#     """Fetch full details for a single recipe"""
#     url = f"https://api.spoonacular.com/recipes/{recipe_id}/information?includeNutrition=true&apiKey={API_KEY}"
#     data = fetch_from_spoonacular(url)
#
#     if "error" in data:
#         return jsonify(data), 500
#
#     # Return relevant fields
#     recipe = {
#         "id": data.get("id"),
#         "title": data.get("title"),
#         "image": data.get("image"),
#         "calories": next((n['amount'] for n in data.get("nutrition", {}).get("nutrients", []) if n["name"] == "Calories"), "N/A"),
#         "readyInMinutes": data.get("readyInMinutes"),
#         "servings": data.get("servings"),
#         "dietLabels": data.get("diets"),
#         "cuisines": data.get("cuisines"),
#         "healthScore": data.get("healthScore"),
#         "instructions": data.get("instructions") or "No instructions available.",
#         "ingredients": [i.get("original") for i in data.get("extendedIngredients", [])]
#     }
#
#     return jsonify(recipe)
#
#
# @app.route("/image")
# def get_image():
#     """Proxy image to avoid CORS issues"""
#     img_url = request.args.get("url")
#     if not img_url:
#         return jsonify({"error": "No URL provided"}), 400
#
#     try:
#         resp = requests.get(img_url, stream=True)
#         resp.raise_for_status()
#         return Response(
#             resp.content,
#             content_type=resp.headers.get("Content-Type", "image/jpeg")
#         )
#     except requests.exceptions.RequestException as e:
#         return jsonify({"error": str(e)}), 500
#
#
# if __name__ == "__main__":
#     app.run(debug=True)


# backend.py
from flask import Flask, jsonify, request, Response
import requests
import os
from dotenv import load_dotenv
from flask_cors import CORS

# Load environment variables
load_dotenv()

app = Flask(__name__)
CORS(app)
API_KEY = os.environ.get("SPOONACULAR_API_KEY")

if not API_KEY:
    raise ValueError("Please set SPOONACULAR_API_KEY in your .env file")


def fetch_recipe_detail_from_api(recipe_id):
    """Fetch detailed recipe info from Spoonacular"""
    url = f"https://api.spoonacular.com/recipes/{recipe_id}/information?includeNutrition=true&apiKey={API_KEY}"
    resp = requests.get(url)
    resp.raise_for_status()
    data = resp.json()

    # Extract ingredients in the format {name, amount, unit, image}
    ingredients = [
        {
            "name": i.get("name"),
            "amount": i.get("amount"),
            "unit": i.get("unit"),
            "image": i.get("image"),
        }
        for i in data.get("extendedIngredients", [])
    ]

    # Extract step-by-step instructions
    instructions = "No instructions available."
    steps = []
    if data.get("analyzedInstructions"):
        steps = [s["step"] for s in data["analyzedInstructions"][0].get("steps", [])]
        instructions = "\n".join(steps)

    return {
        "id": data.get("id"),
        "title": data.get("title"),
        "image": data.get("image"),
        "readyInMinutes": data.get("readyInMinutes"),
        "servings": data.get("servings"),
        "vegetarian": data.get("vegetarian"),
        "vegan": data.get("vegan"),
        "pricePerServing": data.get("pricePerServing"),
        "calories": next(
            (
                n["amount"]
                for n in data.get("nutrition", {}).get("nutrients", [])
                if n["name"] == "Calories"
            ),
            "N/A",
        ),
        "ingredients": ingredients,
        "instructions": instructions,
    }


@app.route("/recipes")
def get_recipes():
    diet = request.args.get("diet", "vegetarian")
    number = request.args.get("number", "10")
    url = f"https://api.spoonacular.com/recipes/complexSearch?diet={diet}&number={number}&addRecipeInformation=true&apiKey={API_KEY}"
    try:
        resp = requests.get(url)
        resp.raise_for_status()
        data = resp.json()
        recipes = []

        for r in data.get("results", []):
            # For each recipe, fetch detailed info
            try:
                detail = fetch_recipe_detail_from_api(r["id"])
                recipes.append(detail)
            except Exception as e:
                print(f"Error fetching recipe {r['id']}: {e}")

        return jsonify({"recipes": recipes})
    except requests.exceptions.RequestException as e:
        return jsonify({"error": str(e)}), 500


@app.route("/recipe/<int:recipe_id>")
def get_recipe_detail(recipe_id):
    try:
        detail = fetch_recipe_detail_from_api(recipe_id)
        return jsonify(detail)
    except requests.exceptions.RequestException as e:
        return jsonify({"error": str(e)}), 500


@app.route("/image")
def get_image():
    img_url = request.args.get("url")
    if not img_url:
        return jsonify({"error": "No URL provided"}), 400
    try:
        resp = requests.get(img_url, stream=True)
        resp.raise_for_status()
        return Response(
            resp.content,
            content_type=resp.headers.get("Content-Type", "image/jpeg")
        )
    except requests.exceptions.RequestException as e:
        return jsonify({"error": str(e)}), 500


if __name__ == "__main__":
    app.run(debug=True)
