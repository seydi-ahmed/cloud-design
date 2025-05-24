# srcs/api-gateway-app/app/proxy.py


from flask import Blueprint, request, jsonify
import os
import requests

INVENTORY_APP_HOST = os.getenv("INVENTORY_APP_HOST")
INVENTORY_APP_PORT = os.getenv("INVENTORY_APP_PORT")

bp = Blueprint("proxy", __name__)

# Routes vers inventory-app
INVENTORY_ENDPOINTS = [
    "/api/movies",
    "/api/movies/<int:id>"
]


@bp.route("/api/movies", methods=["GET", "POST", "DELETE"])
@bp.route("/api/movies/<int:id>", methods=["GET", "PUT", "DELETE"])
def proxy_inventory(id=None):
    try:
        path = f"/api/movies" if id is None else f"/api/movies/{id}"
        url = f"http://{INVENTORY_APP_HOST}:{INVENTORY_APP_PORT}{path}"

        response = requests.request(
            method=request.method,
            url=url,
            headers={k: v for k, v in request.headers if k.lower() not in ['host', 'content-length', 'transfer-encoding']},
            data=request.get_data(),
            params=request.args
        )
        return response.content, response.status_code, response.headers.items()

    except Exception as e:
        return jsonify(error=str(e)), 500




# from flask import Blueprint, request, jsonify

# import os
# import requests

# INVENTORY_APP_HOST = os.getenv("INVENTORY_APP_HOST")
# INVENTORY_APP_PORT = os.getenv("INVENTORY_APP_PORT")


# bp = Blueprint("proxy", __name__)


# @bp.route('/<path:path>', methods=["GET", "POST", "PUT", "DELETE"])
# def gateway(path: str):
#     service_mapping = {
#         "inventory": f'http://{INVENTORY_APP_HOST}:{INVENTORY_APP_PORT}',
#         # Ajoute d'autres services ici
#     }

#     path_parts = path.split('/')
#     service_name = path_parts[0] if len(path_parts) > 0 else None
#     target_service = service_mapping.get(service_name)

#     if target_service:
#         service_path = '/'.join(path_parts[1:])  # ce qu'on envoie à inventory-app
#         try:
#             response = requests.request(
#                 method=request.method,
#                 url=f"{target_service}/{service_path}",
#                 headers=request.headers,
#                 data=request.get_data(),
#                 params=request.args
#             )
#             return (
#                 response.text,
#                 response.status_code,
#                 response.headers.items()
#             )

#         except Exception as e:
#             return jsonify(error=f"{e}"), 500
#     else:
#         return jsonify({'error': 'Service not found'}), 404
