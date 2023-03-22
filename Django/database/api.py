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
    
class Family_History_Info_Api(viewsets.ModelViewSet):
    queryset = Family_History_Info.objects.all()
    serializer_class = Family_History_Info_Serializer
    permission_classes = []

class Contraception_Method_Api(viewsets.ModelViewSet):
    queryset = Contraception_Method.objects.all()
    serializer_class = Contraception_Method_Serializer
    permission_classes = []

#class Contraception_Info_Api(viewsets.ModelViewSet):
#    queryset = Contraception_Info.objects.all()
#    serializer_class = Contraception_Info_Serializer
#    permission_classes = [] 