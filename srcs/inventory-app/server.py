# srcs/inventory-app/app/server.py

from waitress import serve
from app import create_app

import os


PORT = os.getenv("INVENTORY_APP_PORT")

app = create_app()
print(f"Listening on port {PORT}...")

serve(app, listen=f"*:{PORT}")
