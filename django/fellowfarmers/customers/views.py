from othermasters.models import CityMaster
from societymasters.models import SocietyMaster
from django.http.response import JsonResponse
from rest_framework.permissions import IsAuthenticated 
from rest_framework.authentication import TokenAuthentication
from rest_framework.parsers import JSONParser 
from societymasters.models import SocietyMaster
from othermasters.models import CityMaster
from .models import Customer
from .serializers import CustomerSerializer
from rest_framework.views import APIView
import random

# Create your views here.
#/api/customer/checkregister

class checkregister(APIView):
    permission_class=[IsAuthenticated]
    authentication_classes=[TokenAuthentication]
    def get(self,request,mob):
        queryset=Customer.objects.filter(mobile__iexact=mob)
        cust=CustomerSerializer(queryset,context={'request':request},many=True)
        return JsonResponse(cust.data,safe=False)

class checklogin(APIView):
    permission_class=[IsAuthenticated,]
    authentication_classes=[TokenAuthentication]
    def post(self,request):
        customer_data = JSONParser().parse(request)
        print(customer_data)
        queryset=Customer.objects.filter(mobile__iexact=customer_data['mobile'],password__iexact=customer_data['password'])
        print(queryset)
        cust=CustomerSerializer(queryset,context={'request':request},many=True)
        return JsonResponse(cust.data,safe=False)
        

            
class customerregisterwithuserpass(APIView):
    permission_class=[IsAuthenticated]
    authentication_classes=[TokenAuthentication]
    def post(self,request):
        customer_data = JSONParser().parse(request)
        sc=CityMaster(code=random.randint(1,1000),name=customer_data['city'])
        sc.save()
        cityobj=CityMaster.objects.latest('id')
        ss=SocietyMaster(code=random.randint(1,1000),name=customer_data['society'])
        ss.save()
        socobj=SocietyMaster.objects.latest('id')
        sv=Customer(name=customer_data['name'],username=customer_data['username'],password=customer_data['password'],
        mobile=customer_data['mobile'],
        email=customer_data['email'],
        address=customer_data['address'],
        city=cityobj,
        society=socobj)
        sv.save()
        return JsonResponse(customer_data,safe=False)




class customerregister(APIView):
    permission_class=[IsAuthenticated]
    authentication_classes=[TokenAuthentication]
    def post(self,request):
        customer_data = JSONParser().parse(request)
        print(customer_data)
        custobj=Customer.objects.filter(mobile__iexact=customer_data['mobile'])
        print(custobj)
        if custobj:
            return JsonResponse(customer_data,safe=False)
        else:
            soc=SocietyMaster.objects.get(name__iexact=customer_data['society'])
            city=CityMaster.objects.get(name__iexact=customer_data['city'])
            sv=Customer(name=customer_data['name'],username=customer_data['mobile'],password=customer_data['mobile'],mobile=customer_data['mobile'],
            city=city,
            society=soc)
            sv.save()
            return JsonResponse(customer_data,safe=False)
