from othermasters.models import CityMaster
from societymasters.models import SocietyMaster
from django.http.response import JsonResponse
from rest_framework.permissions import IsAuthenticated 
from rest_framework.authentication import TokenAuthentication
from rest_framework.parsers import JSONParser 
from .models import Customer
from .serializers import CustomerSerializer
from rest_framework.views import APIView

# Create your views here.
#/api/customer/checkregister

class checkregister(APIView):
    permission_class=[IsAuthenticated]
    authentication_classes=[TokenAuthentication]
    def get(self,request,mob):
        queryset=Customer.objects.filter(mobile__iexact=mob)
        cust=CustomerSerializer(queryset,context={'request':request},many=True)
        return JsonResponse(cust.data,safe=False)


class customerregister(APIView):
    permission_class=[IsAuthenticated]
    authentication_classes=[TokenAuthentication]
    def post(self,request):
        customer_data = JSONParser().parse(request)
        custobj=Customer.objects.get(mobile=customer_data['mobile'])
        print(custobj)
        if custobj:
            return JsonResponse(customer_data,safe=False)
        else:
            soc=SocietyMaster.objects.get(name__iexact=customer_data['society'])
            city=CityMaster.objects.get(name__iexact=customer_data['city'])
            sv=Customer(name=customer_data['name'],mobile=customer_data['mobile'],
            city=city,
            society=soc)
            sv.save()
            return JsonResponse(customer_data,safe=False)
