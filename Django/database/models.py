from django.db import models
from .utils import *
import json
from django.contrib.postgres.fields import JSONField

class Family_History(models.Model):
    name = models.CharField(max_length=50, unique=True)

    def __str__(self):
        return self.name
    
class Contraception_Info_Method(models.Model):
    method = models.ManyToManyField(Contraception_Method)

class Contraception_Info(models.Model):
    contraception = models.BooleanField(default=False)
    methods = models.ManyToManyField(Contraception_Method)

# Create your models here.
class Patient(models.Model):
    first_name = models.CharField(max_length=50, default='')
    last_name = models.CharField(max_length=50, default='')
    gender = models.CharField(max_length=6, choices=[('male', 'Male'), ('female', 'Female')])
    date_of_birth = models.DateField()
    occupation = models.CharField(max_length=50, default='')
    mobile_number = models.CharField(max_length=11, null=True)
    #marital_status = models.CharField(max_length=50, choices=[('single', 'Single'), ('married', 'Married'), ('divorced', 'Divorced'), ('widowed', 'Widowed')], default='single')
    marriage = models.JSONField(default=dict, null=True)
    education_level = models.CharField(max_length=50, choices=[('illiterate', 'Illiterate'), ('read and write', 'Read and Write'), ('primary', 'Primary'), ('preparatory', 'Preparatory'), ('secondary', 'Secondary'), ('university', 'University'), ('postgraduate', 'Postgraduate')], default='illiterate')
    
    habits_of_medical_importance = models.JSONField(default=dict, null=True)
    complaints = models.JSONField(default=dict, null=True)

    past_history = models.JSONField(default=dict, null=True)
    family_history = models.JSONField(default=dict, null=True)
    
    
    def __str__(self):
        return f"{self.first_name} {self.last_name}" 
    


#class Complaint(models.Model):
#    symptom = models.CharField(max_length=50)
#    code = models.ForeignKey(Patient, on_delete=models.CASCADE)

class UrinAnalysisReport(models.Model):
    status = models.CharField(max_length=10, choices=[('pending', 'Pending'), ('finished', 'Finished'), ('cancelled', 'Cancelled')])
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE)
    report_date = models.DateField(auto_now_add=True)
    lab_code = models.CharField(max_length=50)
    colour = models.CharField(max_length=20)
    aspect = models.CharField(max_length=20)
    blood = models.CharField(max_length=20)
    urobilinogen = models.CharField(max_length=20)
    bilirubin = models.CharField(max_length=20)
    protien = models.CharField(max_length=20)
    nitrite = models.CharField(max_length=20)
    ketone_bodies = models.CharField(max_length=20)
    glucose = models.CharField(max_length=20)
    ph_level = models.CharField(max_length=20)
    specific_gravity = models.CharField(max_length=20)
    leukocyte_esterase = models.CharField(max_length=20)
    rbcs = models.CharField(max_length=20)
    pus_cells = models.CharField(max_length=20)
    epithelial_cells = models.CharField(max_length=20)
    calcium_oxalate = models.CharField(max_length=20)
    uric_acid = models.CharField(max_length=20)
    triple_phosphate = models.CharField(max_length=20)
    amorphous = models.CharField(max_length=20)
    microscopic_findings = models.TextField(null=True, blank=True)
    additional_comments = models.TextField(null=True, blank=True)
    lab_member_signature = models.CharField(max_length=50)
    casts = models.CharField(max_length=20)
    eggs = models.CharField(max_length=20)
    mucus = models.CharField(max_length=20)
    bacteria = models.CharField(max_length=20)
    yeast = models.CharField(max_length=20)
    sperm = models.CharField(max_length=20)
    
    def __str__(self):
        return f"{self.patient.first_name} {self.patient.last_name} - Urinalysis Report ({self.report_date})"