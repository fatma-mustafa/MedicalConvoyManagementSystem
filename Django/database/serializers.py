from .models import *
from rest_framework import serializers
from .utils import *

class PatientSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Patient
        fields = "__all__"

class UrinanalysisReportSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = UrinAnalysisReport
        fields = "__all__"

class Family_History_Serializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Family_History
        fields = "__all__"

class Contraception_Method_Serializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Contraception_Method
        fields = "__all__"

#class Contraception_Info_Serializer(serializers.HyperlinkedModelSerializer):
#    class Meta:
#        model = Contraception_Info
#        fields = "__all__"