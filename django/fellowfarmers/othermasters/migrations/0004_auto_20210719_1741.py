# Generated by Django 3.2.5 on 2021-07-19 12:11

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('othermasters', '0003_alter_citymaster_options'),
    ]

    operations = [
        migrations.AddField(
            model_name='citymaster',
            name='active',
            field=models.BooleanField(default=True),
        ),
        migrations.AddField(
            model_name='societymaster',
            name='active',
            field=models.BooleanField(default=True),
        ),
    ]
