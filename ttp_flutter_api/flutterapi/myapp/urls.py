from django.urls import path
from myapp.views import *

urlpatterns = [
    path('', Home),
    path('api-team6/all-requestlist/',all_requestlist),
    path('api-team6/post-requestlist/', post_requestlist),
    path('api-team6/update-requestlist/<int:TID>', update_requestlist),
    path('api-team6/delete-requestlist/<int:TID>', delete_requestlist)

]