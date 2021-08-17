from django.contrib import admin
from .models import Paymentlog
# Register your models here.
@admin.register(Paymentlog)
class PaymentlogAdmin(admin.ModelAdmin):
    list_display=['transaction_id','price','paymentdate','customerid',]
