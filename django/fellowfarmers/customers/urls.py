from django.urls import path
from .views import *

urlpatterns = [
    path('checkregister/<str:mob>',checkregister.as_view()),
    path('customerregister/',customerregister.as_view()),
]
