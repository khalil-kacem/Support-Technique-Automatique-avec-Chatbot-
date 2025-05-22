from django.urls import path
from . import views

urlpatterns = [
    path('addClient/', views.add_client),
    path('addSupport/', views.add_support),
    path('addAdmin/', views.add_admin),
    path('login/', views.loginn), 
    path('getEquipeSupport/', views.get_equipe_support),
    path('getClient/', views.get_client), 
    path('getproblem/', views.get_problem), 
    path('getproblembyemail/', views.get_problem_by_email),
    path('contactSupport/', views.contact_support),
    path('submitProblem/', views.submit_problem),
    path('addUser/', views.add_user),
    path('signup2/', views.signup_user_with_role),



]
