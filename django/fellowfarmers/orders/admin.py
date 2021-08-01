from django.contrib import admin
from .models import Order
from django.utils.safestring import mark_safe 
from datetime import timedelta,datetime
# Register your models here.

@admin.register(Order)
class OrderAdmin(admin.ModelAdmin):
    list_display=['id','order_number','order_date','customer','schedule_shipping_date','order_type','order_amount','sales_person','delivery_guy','order_status','payment_status'] 
    list_filter=['delivery_staff','schedule_delivery_date']

    def order_number(self,obj):
        return obj.id

    def order_type(self,obj):
        return 'Regular'    

    def  schedule_shipping_date(self,obj):
        return obj.schedule_delivery_date 

    def delivery_guy(self,obj):
        if obj.delivery_staff == None:
            url="/admin/orders/order/{}/change/".format(obj.id)
            return mark_safe('<a href="{}">Allocate</a>'.format(url))
        else:
            return obj.delivery_staff       


class DeliveryMaster(Order):
    class Meta:
        proxy=True

class MyDeliveryAdmin(OrderAdmin):
    list_display=['customer','delivery_Date','order_number','product','delivery_address','quantity','delivery_staff','order_status']  

    def get_queryset(self, request):
        todaytime = datetime.now()
        nextday = datetime.now()
        nextday += timedelta(days=1)
        return Order.objects.filter(schedule_delivery_date__gte=todaytime,schedule_delivery_date__lte=nextday) 

    def delivery_Date(self,obj):
        return obj.schedule_delivery_date    

admin.site.register(DeliveryMaster,MyDeliveryAdmin)



    