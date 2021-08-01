from products.models import Product
from rest_framework import serializers
from .models import SocietyMaster

class SocietySerializer(serializers.ModelSerializer):
    class Meta:
        model=SocietyMaster
        fields=['id','sales','code','name','assign_sale_person','active',]


