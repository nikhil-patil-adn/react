# Generated by Django 3.2.5 on 2021-07-21 04:13

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('bills', '0001_initial'),
    ]

    operations = [
        migrations.DeleteModel(
            name='Postpaid',
        ),
        migrations.DeleteModel(
            name='Prepaid',
        ),
    ]
