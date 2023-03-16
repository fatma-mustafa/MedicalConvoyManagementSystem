import django_filters
from .models import Patient, UrinAnalysisReport

class UrinAnalysisReportFilter(django_filters.FilterSet):
    #status = django_filters.CharFilter(lookup_expr='icontains')
    class Meta:
        model = UrinAnalysisReport
        fields = '__all__'