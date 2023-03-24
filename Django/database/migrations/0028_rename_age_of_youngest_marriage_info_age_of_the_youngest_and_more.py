# Generated by Django 4.1.6 on 2023-03-24 14:40

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('database', '0027_alter_patient_code'),
    ]

    operations = [
        migrations.RenameField(
            model_name='marriage_info',
            old_name='age_of_youngest',
            new_name='age_of_the_youngest',
        ),
        migrations.RenameField(
            model_name='marriage_info',
            old_name='children_number',
            new_name='number_of_children',
        ),
        migrations.RemoveField(
            model_name='marriage_info',
            name='marriage',
        ),
        migrations.AddField(
            model_name='marriage_info',
            name='patient',
            field=models.ForeignKey(default='', on_delete=django.db.models.deletion.CASCADE, to='database.patient'),
            preserve_default=False,
        ),
        migrations.AlterField(
            model_name='patient',
            name='code',
            field=models.CharField(blank=True, editable=False, max_length=10),
        ),
    ]
