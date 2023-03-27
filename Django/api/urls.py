from django.urls import include, path
from rest_framework import routers
from website import api as website
from database import api as database
from rest_framework.authtoken.views import obtain_auth_token

router = routers.DefaultRouter()

router.register('patient', database.PatientApi)

router.register('Clinics', database.ClinicsAPI)
router.register('Follow Up', database.FollowUpAPI)
router.register('Complaints', database.ComplaintsAPI)

#router.register('Contraception_Info', database.Contraception_Info_Api)
urlpatterns = [
    path('', include(router.urls)),
    path('token/', obtain_auth_token),
    #path('api-auth/', include('rest_framework.urls', namespace='rest_framework'))
]