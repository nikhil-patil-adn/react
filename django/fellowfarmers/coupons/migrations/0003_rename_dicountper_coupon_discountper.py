# Generated by Django 3.2.5 on 2021-07-30 12:02

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('coupons', '0002_coupon_dicountper'),
    ]

    operations = [
        migrations.RenameField(
            model_name='coupon',
            old_name='dicountper',
            new_name='discountper',
        ),
    ]
