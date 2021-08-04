from django.urls import path
from .views import *

urlpatterns = [
    path('insertfeedback/',insertfeedback.as_view()),
    path('fetchfeedbackbycustomer/<str:id>',fetchfeedbackbycustomer.as_view()),
    path('test/',getfeedbackdatatest),
]
