from django.urls import path
from .views import *

urlpatterns = [
    path('fetchsubscriptionbycustomer/<int:custid>',fetchsubscriptionbycustomer.as_view()),
    path('testorder/',testorder),
]
