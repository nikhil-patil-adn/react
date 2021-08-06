from django.urls import path
from .views import *

urlpatterns = [
    path('insertorder/',insertorder.as_view()),
    path('getordersbycust/<int:custid>',getordersbycust.as_view()),
    path('testorder/',testorder),
]
