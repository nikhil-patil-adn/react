from django.urls import path
from .views import *

urlpatterns = [
    path('insertorder/',insertorder.as_view()),
]
