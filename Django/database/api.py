from rest_framework import viewsets
from rest_framework import permissions
from .serializers import *
from .models import *
from rest_framework import status
from .filters import UrinAnalysisReportFilter
from rest_framework.response import Response
from .models import *
from django.http import JsonResponse
from datetime import datetime
from django.core import serializers
from django.urls import reverse

class Marriage_Api(viewsets.ModelViewSet):
    queryset = Marriage.objects.all()
    serializer_class = MarriageSerializer
    def create(self, request, *args, **kwargs):
        self.request=request
        self.format_kwarg = kwargs

        serializer = self.get_serializer(data=args[0])
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)

        #return JsonResponse("", safe=False)
    
    def get_queryset(self):
        print(self.request)
        return super().get_queryset()

class PatientApi(viewsets.ModelViewSet):
    queryset = Patient.objects.all()
    serializer_class = PatientSerializer
    permission_classes = []

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)        
        serializer.is_valid(raise_exception=True)

        code = self.generate_id()
        serializer.validated_data['code'] = code

        
        self.perform_create(serializer)

        marriage = dict(json.loads(request.data['marriage']))
        
        marriage['patient'] = code[3:]

        marriage_api = Marriage_Api()
        marriage_api.create(request, marriage)


        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)
    
    def generate_id(self):
        prefix=datetime.now().strftime("%a")[:3].upper()
        code = Patient.objects.order_by('pk').last()
        if code:
            code = code.id + 1
        else:
            code = 0
        return f'{prefix}{code}'

class UrinanalysisReportApi(viewsets.ModelViewSet):
    queryset = UrinAnalysisReport.objects.all()
    serializer_class = UrinanalysisReportSerializer
    permission_classes = []
    filterset_class = UrinAnalysisReportFilter
    
class Family_History_Api(viewsets.ModelViewSet):
    queryset = Family_History.objects.all()
    serializer_class = Family_History_Serializer
    permission_classes = []

class Contraception_Method_Api(viewsets.ModelViewSet):
    queryset = Contraception_Method.objects.all()
    serializer_class = Contraception_Method_Serializer
    permission_classes = []

#class Contraception_Info_Api(viewsets.ModelViewSet):
#    queryset = Contraception_Info.objects.all()
#    serializer_class = Contraception_Info_Serializer
#    permission_classes = [] 