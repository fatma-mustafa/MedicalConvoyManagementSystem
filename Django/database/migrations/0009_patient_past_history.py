# Generated by Django 4.1.6 on 2023-03-23 13:50

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('database', '0008_rename_family_history_info_family_history_complaint'),
    ]

    operations = [
        migrations.AddField(
            model_name='patient',
            name='past_history',
            field=models.JSONField(default=''),
        ),
    ]
