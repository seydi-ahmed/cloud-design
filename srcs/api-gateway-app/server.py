# srcs/api-gateway-app/server.py

from app import create_app
from waitress import serve
from prometheus_flask_exporter import PrometheusMetrics

import os

APP_PORT = os.getenv("APIGATEWAY_PORT", 3000)

app = create_app()
metrics = PrometheusMetrics(app)

serve(app, listen=f"*:{APP_PORT}")
