from django.urls import path
from myapp.views import *

urlpatterns = [
    path('', Home),
    path('api-team6/allrequestlist/',all_requestlist),

]