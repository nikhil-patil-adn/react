from django.shortcuts import render
from django.core.mail import send_mail
from django.conf import settings
from twilio.rest import Client
from django.http.response import JsonResponse
from rest_framework.parsers import JSONParser 
from rest_framework.permissions import IsAuthenticated 
from rest_framework.authentication import TokenAuthentication
from rest_framework.views import APIView

# Create your views here.


def sendemailcommon(request):
    subject = request['subject']
    message = request['message']
    fromemail=settings.EMAIL_HOST_USER
    to=request['to']
    send_mail(subject, message, fromemail,to)
    return True


class sendsmsapi(APIView):

    permission_classes=[IsAuthenticated,]
    authentication_classes=[TokenAuthentication,]
    def post(self,request):
        customer_data = JSONParser().parse(request)
        print(customer_data)
        data={'body':customer_data['otp'],'to':customer_data['mobile']}
        sendsmscommon(data)
        sms={'success':True}    
        return JsonResponse(sms,safe=False)



def sendsmscommon(request):
    body=request['body']
    to='+91'+request['to']
    fromsend=settings.TWILIO_NUMBER
    client = Client(settings.TWILIO_ACCOUNT_SID, settings.TWILIO_AUTH_TOKEN)
    message = client.messages.create(to=to, from_=fromsend,body=body)
    print(message.sid)
    return True