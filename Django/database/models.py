from django.db import models

# Create your models here.
class Patient(models.Model):
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)
    date_of_birth = models.DateField()
    gender = models.CharField(max_length=6, choices=[('male', 'Male'), ('female', 'Female')])
    address = models.CharField(max_length=200)
    phone_number = models.CharField(max_length=11)
    last_checkup_date = models.DateField(null=True, blank=True)
    medical_history=models.TextField(null=True, blank=True)

    def __str__(self):
        return f"{self.first_name} {self.last_name}" 
    
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