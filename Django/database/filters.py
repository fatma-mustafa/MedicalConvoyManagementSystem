import django_filters
from .models import Patient, UrinAnalysisReport

class PatientFilter(django_filters.FilterSet):
    #name = django_filters.CharFilter(lookup_expr='icontains')
    #marriage = django_filters.CharFilter(lookup_expr='icontains')
    #habits_of_medical_importance = django_filters.CharFilter(lookup_expr='icontains')
    #past_history = django_filters.CharFilter(lookup_expr='icontains')
    #family_history = django_filters.CharFilter(lookup_expr='icontains')
    #complexion = django_filters.CharFilter(lookup_expr='icontains')
    #complaints = django_filters.CharFilter(lookup_expr='icontains')
    #clinics = django_filters.CharFilter(lookup_expr='icontains')
    class Meta:
        model = Patient
        fields = ['name']
        
class UrinAnalysisReportFilter(django_filters.FilterSet):
    #status = django_filters.CharFilter(lookup_expr='icontains')
    class Meta:
        model = UrinAnalysisReport
        fields = '__all__'

    