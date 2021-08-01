from django.urls import path
from .views import *

urlpatterns = [
    path('getsociety/<str:soc>',getAllSociety.as_view()),
]
