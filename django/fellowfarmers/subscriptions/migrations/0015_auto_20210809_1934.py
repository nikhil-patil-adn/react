# Generated by Django 3.2.5 on 2021-08-09 14:04

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('products', '0006_product_issubscribed'),
        ('customers', '0007_auto_20210802_1450'),
        ('subscriptions', '0014_auto_20210805_1702'),
    ]

    operations = [
        migrations.AlterField(
            model_name='subscription',
            name='customer',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='cust', to='customers.customer'),
        ),
        migrations.AlterField(
            model_name='subscription',
            name='product',
            field=models.ForeignKey(default=1, on_delete=django.db.models.deletion.CASCADE, related_name='prd', to='products.product'),
        ),
    ]