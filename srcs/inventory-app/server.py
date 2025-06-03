# srcs/inventory-app/app/server.py

from waitress import serve
from app import create_app
from prometheus_flask_exporter import PrometheusMetrics

import os

PORT = os.getenv("INVENTORY_APP_PORT", 8080)

app = create_app()
metrics = PrometheusMetrics(app)

print(f"Listening on port {PORT}...")
serve(app, listen=f"*:{PORT}")
