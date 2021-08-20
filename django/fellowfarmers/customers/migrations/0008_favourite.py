# Generated by Django 3.2.5 on 2021-08-19 04:50

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('products', '0006_product_issubscribed'),
        ('customers', '0007_auto_20210802_1450'),
    ]

    operations = [
        migrations.CreateModel(
            name='Favourite',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created', models.DateTimeField(auto_now_add=True)),
                ('updated', models.DateTimeField(auto_now=True)),
                ('customer', models.OneToOneField(on_delete=django.db.models.deletion.DO_NOTHING, to='customers.customer')),
                ('product', models.OneToOneField(on_delete=django.db.models.deletion.DO_NOTHING, to='products.product')),
            ],
        ),
    ]
