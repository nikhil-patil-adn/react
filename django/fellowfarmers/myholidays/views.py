import datetime
from myholidays.models import MyHoliday
from customers.models import Customer
from django.shortcuts import render
from django.http.response import JsonResponse,HttpResponse
from rest_framework.permissions import IsAuthenticated 
from rest_framework.authentication import TokenAuthentication
from rest_framework.views import APIView
from rest_framework.parsers import JSONParser 
from .serializers import MyHolidaySerializer
import requests

# Create your views here.


def getholidaydatatest(request):
    #url = 'http://127.0.0.1:8000/api/products/details/2'
    url='http://192.168.2.107:8000/api/myholidays/fetchholidaybycustomer/8'
    headers = {'Authorization': 'Token 8334d1d63c97cc583ac50fc034afaf5f57833251'}
    r = requests.get(url, headers=headers)
    print(r)
    return HttpResponse("hi")

class fetchholidaybycustomer(APIView):
    permission_classes=[IsAuthenticated,]
    authentication_classes=[TokenAuthentication,]

    def get(self,request,id):
        queryset=MyHoliday.objects.filter(customer=id).order_by('-id')
        holidays=MyHolidaySerializer(queryset,context={'request':request},many=True)
        return JsonResponse(holidays.data,safe=False)




class insertholiday(APIView):
    permission_classes=[IsAuthenticated,]
    authentication_classes=[TokenAuthentication,]

    def post(self,request):
        holiday_data = JSONParser().parse(request)
        print(holiday_data)
        custobj=Customer.objects.get(id=holiday_data['custid'])
        startdate = holiday_data['startdate'].split(" ")
        startdate[-1] = startdate[-1][:8]
        startdate = " ".join(startdate)
        startdate=datetime.datetime.strptime(startdate,'%Y-%m-%d %H:%M:%S')
        enddate = holiday_data['enddate'].split(" ")
        enddate[-1] = enddate[-1][:8]
        enddate = " ".join(enddate)
        enddate=datetime.datetime.strptime(enddate,'%Y-%m-%d %H:%M:%S')
        sv=MyHoliday(
            customer=custobj,
            startdate=startdate,
            enddate=enddate
        )
        sv.save()
        return JsonResponse(holiday_data,safe=False)


