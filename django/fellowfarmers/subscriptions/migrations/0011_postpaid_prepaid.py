# Generated by Django 3.2.5 on 2021-07-21 04:13

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('subscriptions', '0010_alter_subscription_delivery_staff'),
    ]

    operations = [
        migrations.CreateModel(
            name='Postpaid',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('number_of_advance_days_allow', models.IntegerField()),
                ('negative_balance', models.DecimalField(decimal_places=2, default='00.00', max_digits=6)),
                ('created', models.DateTimeField(auto_now_add=True)),
                ('updated', models.DateTimeField(auto_now=True)),
            ],
        ),
        migrations.CreateModel(
            name='Prepaid',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('number_of_advance_days_allow', models.IntegerField()),
                ('negative_balance', models.DecimalField(decimal_places=2, default='00.00', max_digits=6)),
                ('created', models.DateTimeField(auto_now_add=True)),
                ('updated', models.DateTimeField(auto_now=True)),
            ],
        ),
    ]
