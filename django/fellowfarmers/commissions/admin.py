from django.contrib import admin
from .models import SalePersonCommission

# Register your models here.
@admin.register(SalePersonCommission)
class SalePersonCommissionAdmin(admin.ModelAdmin):
    list_display=['sale_person','commission_percentage','status']