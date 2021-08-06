from django.contrib import admin
from .models import FrequencyMaster
# Register your models here.
@admin.register(FrequencyMaster)
class FrequencyMasterAdmin(admin.ModelAdmin):
    list_display=['product','label_name','number_of_days',]
