# Generated by Django 4.1.6 on 2023-03-24 11:17

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('database', '0020_alter_patient_complaints'),
    ]

    operations = [
        migrations.CreateModel(
            name='Marriage',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('marital_status', models.CharField(choices=[('single', 'Single'), ('married', 'Married'), ('divoced', 'Divorced'), ('windowed', 'Widowed')], max_length=20)),
            ],
        ),
        migrations.RemoveField(
            model_name='patient',
            name='marriage',
        ),
        migrations.CreateModel(
            name='Marriage_info',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('children_number', models.IntegerField()),
                ('age_of_youngest', models.IntegerField()),
                ('marriage', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='database.marriage')),
            ],
        ),
        migrations.AddField(
            model_name='marriage',
            name='patient',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='database.patient'),
        ),
    ]
