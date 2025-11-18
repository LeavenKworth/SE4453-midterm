from flask import Flask, jsonify
import psycopg2
from azure.identity import DefaultAzureCredential
from azure.keyvault.secrets import SecretClient
import os

app = Flask(__name__)

# --- Get Key Vault URI from environment variable ---
KV_URI = os.environ.get("KEY_VAULT_URI")


# --- Initialize Key Vault client ---
credential = DefaultAzureCredential()
secret_client = SecretClient(vault_url=KV_URI, credential=credential)

# --- Retrieve secrets from Key Vault ---
DB_USER = secret_client.get_secret("USERNAME").value
DB_PASSWORD = secret_client.get_secret("PASSWORD").value
DB_HOST = secret_client.get_secret("HOST").value
DB_PORT = secret_client.get_secret("PORT").value
DB_NAME = secret_client.get_secret("DBNAME").value


# --- Database connection function ---
def get_db_connection():
    conn = psycopg2.connect(
        host=DB_HOST,
        port=DB_PORT,
        dbname=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD
    )
    return conn
