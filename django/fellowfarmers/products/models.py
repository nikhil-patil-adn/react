from django.db import models
from othermasters.models import CityMaster
from societymasters.models import SocietyMaster
from django.utils.html import mark_safe

# Create your models here.

class Product(models.Model):
    code=models.IntegerField()
    name=models.CharField(max_length=200)
    image=models.ImageField(upload_to='images/')
    desciption=models.TextField(default="Desciption")
    city=models.ForeignKey(CityMaster,on_delete=models.CASCADE)
    society=models.ForeignKey(SocietyMaster,on_delete=models.CASCADE,null=True)
    price=models.DecimalField(max_digits=5, decimal_places=2)
    created=models.DateTimeField(auto_now_add=True)
    updated=models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name


    def product_image(self):
        return mark_safe('<img src="/%s" width="50" height="50" />' % (self.image))    

      