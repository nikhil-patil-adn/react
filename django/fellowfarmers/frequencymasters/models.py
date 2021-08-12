from django.db import models
from products.models import Product

# Create your models here.
class FrequencyMaster(models.Model):
    product=models.ForeignKey(Product,on_delete=models.CASCADE)#never put on delete
    label_name=models.CharField(max_length=200)
    number_of_days=models.CharField(max_length=200)
    created=models.DateTimeField(auto_now_add=True,blank=True)
    updated=models.DateTimeField(auto_now=True,blank=True)
