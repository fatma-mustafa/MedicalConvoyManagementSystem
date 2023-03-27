from rest_framework import viewsets
from rest_framework import permissions
from .serializers import *
from .models import *
from .filters import UrinAnalysisReportFilter

class ComplaintsAPI(viewsets.ModelViewSet):
    queryset = Complaints.objects.all()
    serializer_class = ComplaintsSerializer

    
class FollowUpAPI(viewsets.ModelViewSet):
    queryset = FollowUp.objects.all()
    serializer_class = FollowUpSerializer
    
class ClinicsAPI(viewsets.ModelViewSet):
    queryset = Clinics.objects.all()
    serializer_class = ClinicsSerializer

class PatientApi(viewsets.ModelViewSet):
    queryset = Patient.objects.all()
    serializer_class = PatientSerializer
    permission_classes = []

class UrinanalysisReportApi(viewsets.ModelViewSet):
    queryset = UrinAnalysisReport.objects.all()
    serializer_class = UrinanalysisReportSerializer
    permission_classes = []
    filterset_class = UrinAnalysisReportFilter