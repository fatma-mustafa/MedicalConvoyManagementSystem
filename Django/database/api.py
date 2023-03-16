from rest_framework import viewsets
from rest_framework import permissions
from .serializers import *
from .models import *
from .filters import UrinAnalysisReportFilter
class PatientApi(viewsets.ModelViewSet):
    queryset = Patient.objects.all()
    serializer_class = PatientSerializer
    permission_classes = []


class UrinanalysisReportApi(viewsets.ModelViewSet):
    queryset = UrinAnalysisReport.objects.all()
    serializer_class = UrinanalysisReportSerializer
    permission_classes = []
    filterset_class = UrinAnalysisReportFilter
