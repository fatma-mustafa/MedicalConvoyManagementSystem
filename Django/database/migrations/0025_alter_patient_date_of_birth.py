# Generated by Django 4.1.6 on 2023-03-24 12:35

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('database', '0024_alter_patient_prefix'),
    ]

    operations = [
        migrations.AlterField(
            model_name='patient',
            name='date_of_birth',
            field=models.DateField(null=True),
        ),
    ]
