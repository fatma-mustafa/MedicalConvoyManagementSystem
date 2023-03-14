from .models import *
from rest_framework import serializers

class PatientSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Patient
        fields = "__all__"

class UrinanalysisReportSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = UrinAnalysisReport
        fields = "__all__"