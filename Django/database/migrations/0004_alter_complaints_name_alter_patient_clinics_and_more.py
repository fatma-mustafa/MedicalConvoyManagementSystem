# Generated by Django 4.1.6 on 2023-03-27 16:05

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('database', '0003_delete_cyanosis_alter_patient_complexion'),
    ]

    operations = [
        migrations.AlterField(
            model_name='complaints',
            name='name',
            field=models.CharField(default='', max_length=70),
            preserve_default=False,
        ),
        migrations.AlterField(
            model_name='patient',
            name='clinics',
            field=models.JSONField(default=dict, null=True),
        ),
        migrations.AlterField(
            model_name='patient',
            name='complaints',
            field=models.JSONField(default=dict, null=True),
        ),
    ]
