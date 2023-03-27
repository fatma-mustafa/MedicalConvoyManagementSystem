from .models import *
from rest_framework import serializers
from .utils import *
from .filters import *
from django_filters.rest_framework import DjangoFilterBackend

class ComplaintsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Complaints
        fields = '__all__'

    def create(self, validated_data):
        print(validated_data)
        return super().create(validated_data)
    
class FollowUpSerializer(serializers.ModelSerializer):
    class Meta:
        model=FollowUp
        fields='__all__'

class ClinicsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Clinics
        fields = '__all__'

class PatientSerializer(serializers.HyperlinkedModelSerializer):    
    class Meta:
        model = Patient
        filter_backends = [DjangoFilterBackend]
        filterset_fields = ['name', 'code']
        fields = "__all__"
    

class UrinanalysisReportSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = UrinAnalysisReport
        fields = "__all__"

