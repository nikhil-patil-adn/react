from django.urls import path
from .views import *

urlpatterns = [
    path('insertorder/',insertorder.as_view()),
    path('getordersbycust/<int:custid>',getordersbycust.as_view()),
    path('fetchbuynowbycustomer/<int:custid>',fetchbuynowbycustomer.as_view()),
    path('test/',testorder),
]
