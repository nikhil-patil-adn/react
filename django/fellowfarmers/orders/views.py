from django.db.models.query import QuerySet
from django.http.response import JsonResponse,HttpResponse
import datetime

from rest_framework.permissions import IsAuthenticated 
from rest_framework.authentication import TokenAuthentication
from rest_framework.parsers import JSONParser 
from customers.models import Customer
from products.models import Product
from subscriptions.models import Subscription
from .models import Order
from .serializers import OrderSerializer
from rest_framework.views import APIView
import json
import requests

# Create your views here.

def testorder(request):
    #url='http://192.168.2.107:8000/api/order/getordersbycust/8'
    url='http://127.0.0.1:8000/api/orders/fetchsubscriptiobycustomer/8'
    headers = {'Authorization': 'Token 8334d1d63c97cc583ac50fc034afaf5f57833251'}
    r = requests.get(url, headers=headers)
    print(r)
    return HttpResponse("hi")

class getordersbycust(APIView):
    permission_classes=[IsAuthenticated,]
    authentication_classes=[TokenAuthentication,]

    def get(self,request,custid):
        QuerySet=Order.objects.filter(customer=custid)
        orderdata=OrderSerializer(QuerySet,context={'request':request},many=True)
        return JsonResponse(orderdata.data,safe=False)




class insertorder(APIView):
    permission_classes=[IsAuthenticated,]
    authentication_classes=[TokenAuthentication,]
    def post(self,request):
        customer_data = JSONParser().parse(request)
        print(customer_data)
        cust=Customer.objects.get(mobile=customer_data['mobile'])
        prd=Product.objects.get(id=customer_data['selectedproductcode'])
        deliveryaddress=customer_data['address']+","+customer_data['society']+","+customer_data['city']+","+customer_data['pincode']
        if customer_data['btntype'] == 'subscription':
            diffday=1 

            # if customer_data['prepaidoption'] == '1':
            #     daysrange=31
            # elif customer_data['prepaidoption'] == '2':
            #     daysrange=61
            # elif customer_data['prepaidoption'] == '3':
            #     daysrange=91 
            if customer_data['prepaidoption'] > '1':
                daysrange=int(customer_data['prepaidoption'])+int(1)  
            elif customer_data['subscriptionpaymenttype'] == 'postpaid':
                daysrange=16  
                
            if customer_data['subscriptiontype'] == 'alternate':
                diffday=2          
            selecteddate=customer_data['selecteddate']
            selecteddate = selecteddate.split(" ")
            selecteddate[-1] = selecteddate[-1][:8]
            selecteddate = " ".join(selecteddate)
            enddate=datetime.datetime.strptime(selecteddate,'%Y-%m-%d %H:%M:%S')+datetime.timedelta(days=30)
            ss=Subscription(
                subscription_start=customer_data['selecteddate'],
                subscription_end=enddate,
                customer=cust,
                delivery_address=deliveryaddress,
                product=prd,
                quantity=customer_data['quantity'],
                subscription_type=customer_data['subscriptionpaymenttype'],
                frequency_type=customer_data['subscriptiontype']
            )
            ss.save()
            for x in range(1,daysrange,diffday):
                shipday=x-1
                newshipdate=datetime.datetime.strptime(selecteddate,'%Y-%m-%d %H:%M:%S')+datetime.timedelta(days=shipday)

                sv=Order(
                customer=cust,
                delivery_address=deliveryaddress,
                product=prd,
                quantity=customer_data['quantity'],
                order_type=customer_data['btntype'],
                order_amount=customer_data['prize'],
                order_status='delivery scheduled',
                payment_status='Paid',
                subscription_type=customer_data['subscriptiontype'],
                subscription_payment_type=customer_data['subscriptionpaymenttype'],
                prepaid_option=customer_data['prepaidoption'],
                schedule_delivery_date=newshipdate)
                sv.save()
            orderdata = Order.objects.values().latest('id')
            return JsonResponse(orderdata,safe=False)
        else:
            sv=Order(
            customer=Customer.objects.get(mobile=customer_data['mobile']),
            delivery_address=customer_data['address']+","+customer_data['society']+","+customer_data['city']+","+customer_data['pincode'],
            product=Product.objects.get(id=customer_data['selectedproductcode']),
            quantity=customer_data['quantity'],
            order_type=customer_data['btntype'],
            order_amount=customer_data['prize'],
            order_status='delivery scheduled',
            payment_status='Paid',
            subscription_type=customer_data['subscriptiontype'],
            subscription_payment_type=customer_data['subscriptionpaymenttype'],
            prepaid_option=customer_data['prepaidoption'],
            schedule_delivery_date=customer_data['selecteddate'])
            sv.save()
            orderdata = Order.objects.values().latest('id')
            return JsonResponse(orderdata,safe=False)






        
        
        
