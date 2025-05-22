from django.shortcuts import render
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import json
from .mongo import users_collection, support_collection, admin_collection,problems_collection,support_contacts_collection
from django.contrib.auth.hashers import make_password  
from django.contrib.auth.hashers import check_password
from urllib.parse import parse_qs

@csrf_exempt
def add_client(request):
    if request.method == "POST":
        data = json.loads(request.body)
        user = {
            "nom": data.get("nom"),
            "email": data.get("email"),
            "password": make_password(data.get("password")), 
            "ref_entreprise": data.get("ref_entreprise")
        }
        users_collection.insert_one(user)
        return JsonResponse({"message": "User added successfully!"})
    return JsonResponse({"error": "Only POST allowed"}, status=405)

@csrf_exempt
def add_support(request):
    if request.method == "POST":
        data = json.loads(request.body)
        user = {
            "nom": data.get("nom"),
            "email": data.get("email"),
            "password": make_password(data.get("password")),  
            "role": data.get("role")
        }
        support_collection.insert_one(user)
        return JsonResponse({"message": "Equipe Support added successfully!"})
    return JsonResponse({"error": "Only POST allowed"}, status=405)

@csrf_exempt
def add_admin(request):
    if request.method == "POST":
        data = json.loads(request.body)
        user = {
            "username": data.get("username"),
            "password": make_password(data.get("password")),  
        }
        admin_collection.insert_one(user)
        return JsonResponse({"message": "Admin added successfully!"})
    return JsonResponse({"error": "Only POST allowed"}, status=405)


@csrf_exempt
def loginn(request):
    if request.method == "POST":
        try:
            data = json.loads(request.body)

            email = data.get("email")
            password = data.get("password")
            role = data.get("role")

            if role == "Client":
                target_collection = users_collection
            elif role == "Support technique":
                target_collection = support_collection
            else:
                return JsonResponse({"error": "Invalid role provided!"}, status=400)

            found_user = target_collection.find_one({"email": email})

            if found_user:
                hashed_password = found_user.get("password")

                # Verify password
                if check_password(password, hashed_password):
                    return JsonResponse({"message": f"Login successful for role: {role}"}, status=200)
                else:
                    return JsonResponse({"error": "Invalid email or password!"}, status=401)
            else:
                return JsonResponse({"error": "Invalid email or password!"}, status=401)

        except Exception as e:
            return JsonResponse({"error": str(e)}, status=500)

    else:
        return JsonResponse({"error": "Only POST method is supported!"}, status=405)
    

@csrf_exempt
def get_equipe_support(request):
    if request.method == "GET":
        try:
            support_team = list(support_collection.find({}, {'_id': 0}))  
            
            return JsonResponse(support_team, safe=False, status=200)
        
        except Exception as e:
            return JsonResponse({"error": f"Error retrieving data: {str(e)}"}, status=500)
    
    else:
        return JsonResponse({"error": "Only GET method is supported!"}, status=405)
    
@csrf_exempt
def get_client(request):
    if request.method == "GET":
        try:
            clients = list(users_collection.find({}, {'_id': 0}))
            
            return JsonResponse(clients, safe=False, status=200)
        
        except Exception as e:
            return JsonResponse({"error": f"Error retrieving data: {str(e)}"}, status=500)
    
    else:
        return JsonResponse({"error": "Only GET method is supported!"}, status=405)
@csrf_exempt
def get_problem(request):
    if request.method == "GET":
        try:
            problems = list(problems_collection.find({}, {'_id': 0}))  
            
            return JsonResponse(problems, safe=False, status=200)
        
        except Exception as e:
            return JsonResponse({"error": f"Error retrieving data: {str(e)}"}, status=500)
    
    else:
        return JsonResponse({"error": "Only GET method is supported!"}, status=405)
    
@csrf_exempt
def get_problem_by_email(request):
    if request.method == "GET":
        try:
            query_params = parse_qs(request.META['QUERY_STRING'])
            email = query_params.get('email', [None])[0]

            if not email:
                return JsonResponse({"error": "Email parameter is required!"}, status=400)

            problems = list(support_contacts_collection.find({"contactEmail": email}, {'_id': 0}))

            if problems:
                return JsonResponse(problems, safe=False, status=200)
            else:
                return JsonResponse({"message": "No problems found for this email."}, status=404)

        except Exception as e:
            return JsonResponse({"error": f"Error retrieving data: {str(e)}"}, status=500)
    
    else:
        return JsonResponse({"error": "Only GET method is supported!"}, status=405)

@csrf_exempt
def contact_support(request):
    if request.method == "POST":
        try:
            data = json.loads(request.body)

            nom = data.get("nom")
            prenom = data.get("prenom")
            description = data.get("description")
            ref_entreprise = data.get("refEntreprise")
            contact_email = data.get("contactEmail")
            telephone = data.get("telephone")

            support_contact = {
                "nom": nom,
                "prenom": prenom,
                "description": description,
                "refEntreprise": ref_entreprise,
                "contactEmail": contact_email,
                "telephone": telephone
            }

            support_contacts_collection.insert_one(support_contact)

            return JsonResponse({"message": "Support contact submitted successfully!"}, status=200)

        except Exception as e:
            return JsonResponse({"error": f"Error submitting support contact: {str(e)}"}, status=500)

    else:
        return JsonResponse({"error": "Only POST method is supported!"}, status=405)
    
@csrf_exempt
def submit_problem(request):
    if request.method == "POST":
        try:
            data = json.loads(request.body)

            expediteur = data.get("expediteur")
            ref_entreprise = data.get("refEntreprise")
            probleme = data.get("probleme")
            reponse = data.get("reponse")

            problem_document = {
                "expediteur": expediteur,
                "refEntreprise": ref_entreprise,
                "probleme": probleme,
                "reponse": reponse
            }

            problems_collection.insert_one(problem_document)

            return JsonResponse({"message": "Problem and response submitted successfully!"}, status=200)

        except Exception as e:
            return JsonResponse({"error": f"Error submitting problem: {str(e)}"}, status=500)

    else:
        return JsonResponse({"error": "Only POST method is supported!"}, status=405)
    
@csrf_exempt
def add_user(request):
    if request.method == "POST":
        try:
            data = json.loads(request.body)

            username = data.get("username")
            email = data.get("email")
            password = data.get("password")
            company_ref = data.get("company_reference")

            user = {
                "username": username,
                "email": email,
                "password": password,  
                "company_reference": company_ref
            }

            users_collection.insert_one(user)

            return JsonResponse({"message": "User added successfully!"}, status=200)

        except Exception as e:
            return JsonResponse({"error": str(e)}, status=500)

    else:
        return JsonResponse({"error": "Only POST method is supported!"}, status=405)
    
@csrf_exempt
def signup_user_with_role(request):
    if request.method == "POST":
        try:
            data = json.loads(request.body)

            nom = data.get("nom")
            email = data.get("email")
            password = data.get("password")
            role = data.get("role")

            user = {
                "nom": nom,
                "email": email,
                "password": password, 
                "role": role
            }

            support_collection.insert_one(user)

            return JsonResponse({"message": "User with role added successfully!"}, status=200)

        except Exception as e:
            return JsonResponse({"error": f"Error adding user with role: {str(e)}"}, status=500)

    else:
        return JsonResponse({"error": "Only POST method is supported!"}, status=405)