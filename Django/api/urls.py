from django.urls import include, path
from rest_framework import routers
from website import api as website
from database import api as database
from rest_framework.authtoken.views import obtain_auth_token

router = routers.DefaultRouter()

router.register('patient', database.PatientApi)
router.register('UrinAnalysisReport', database.UrinanalysisReportApi)
router.register('Family_History_Info', database.Family_History_Info_Api)
router.register('Contraception_Methods', database.Contraception_Method_Api)
#router.register('Contraception_Info', database.Contraception_Info_Api)
urlpatterns = [
    path('', include(router.urls)),
    path('token/', obtain_auth_token),
    #path('api-auth/', include('rest_framework.urls', namespace='rest_framework'))
]