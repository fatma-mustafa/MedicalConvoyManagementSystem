# Generated by Django 4.1.6 on 2023-03-22 07:14

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('database', '0004_contraception_method_alter_family_history_info_name_and_more'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='contraception_info',
            name='method',
        ),
        migrations.AddField(
            model_name='contraception_info',
            name='methods',
            field=models.ManyToManyField(to='database.contraception_info_method'),
        ),
    ]
