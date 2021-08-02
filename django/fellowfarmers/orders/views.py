from django.http.response import JsonResponse


from rest_framework.permissions import IsAuthenticated 
from rest_framework.authentication import TokenAuthentication
from rest_framework.parsers import JSONParser 
from customers.models import Customer
from products.models import Product
from .models import Order
from .serializers import OrderSerializer
from rest_framework.views import APIView
import json

# Create your views here.


class insertorder(APIView):
    permission_classes=[IsAuthenticated,]
    authentication_classes=[TokenAuthentication,]
    def post(self,request):
        customer_data = JSONParser().parse(request)
        print(customer_data)
        sv=Order(
        customer=Customer.objects.get(mobile=customer_data['mobile']),
        delivery_address=customer_data['society']+","+customer_data['city'],
        product=Product.objects.get(id=customer_data['selectedproductcode']),
        quantity=customer_data['quantity'],
        order_type='buynow',
        order_amount=customer_data['prize'],
        order_status='delivery scheduled',
        payment_status='Paid')
        sv.save()
        orderdata = Order.objects.values().latest('id')
        return JsonResponse(orderdata,safe=False)
