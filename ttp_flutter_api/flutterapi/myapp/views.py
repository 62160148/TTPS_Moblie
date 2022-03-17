from django.shortcuts import render
from django.http import JsonResponse

from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import status
from .serializers import TtpSerializers
from .models import TemporaryTagPermission

# Get Data
@api_view(['GET'])
def all_requestlist(request):
    allrequestlist = TemporaryTagPermission.objects.all()  # ดึงข้อมูลจาก model Team6TTPlist
    serializer = TtpSerializers(allrequestlist, many=True)
    return Response(serializer.data, status=status.HTTP_200_OK)

data = [

    {
        "startdate": "2022-03-17",
        "enddate": "2022-03-18",
        "item": "พัดลม DENSO",
        "reason": "ต้องการวางของไว้ชั่วคราว",
        "tel": "0925215235",
        "supervisor": "Chakrit Boonprasert",
        "approveplant": "Plant 1"
    }
    
]

def Home(request) : 
    return JsonResponse(data = data,safe = False, json_dumps_params= {'ensure_ascii' : False} )