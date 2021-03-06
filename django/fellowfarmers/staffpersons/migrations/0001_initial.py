# Generated by Django 3.2.5 on 2021-07-19 12:39

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('othermasters', '0004_auto_20210719_1741'),
    ]

    operations = [
        migrations.CreateModel(
            name='StaffPerson',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('code', models.IntegerField()),
                ('name', models.CharField(max_length=200)),
                ('email', models.CharField(max_length=200)),
                ('address', models.TextField()),
                ('designation', models.CharField(choices=[('SALES PERSON', 'Sales Person'), ('DELIVERY GUY', 'Delivery Guy')], max_length=20)),
                ('created', models.DateTimeField(auto_now_add=True)),
                ('updated', models.DateTimeField(auto_now=True)),
                ('city', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='othermasters.citymaster')),
            ],
        ),
    ]
