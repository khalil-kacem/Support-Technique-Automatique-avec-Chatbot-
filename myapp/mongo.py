# api/mongo.py
from pymongo import MongoClient

client = MongoClient("mongodb://localhost:27017")
db = client["python_support_entreprise"]
users_collection = db["client"]
support_collection = db["equipe_support"]
admin_collection = db["admin"]

problems_collection = db["problems"]
support_contacts_collection = db["support_contacts"]
