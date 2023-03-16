from django.urls import include, path
from rest_framework import routers
from website import api as website
from database import api as database
from .views import test

router = routers.DefaultRouter()

router.register('patient', database.PatientApi)
router.register('UrinAnalysisReport', database.UrinanalysisReportApi)

urlpatterns = [
    path('', include(router.urls)),
    path('test/', test),
    #path('api-auth/', include('rest_framework.urls', namespace='rest_framework'))
]