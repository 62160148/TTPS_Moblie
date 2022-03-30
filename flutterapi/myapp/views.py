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

# POST Data
@api_view(['POST'])
def post_requestlist(request):
    if request.method == 'POST':
        serializer = TtpSerializers(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_404_NOT_FOUND)

# Update Data
@api_view(['PUT'])
def update_requestlist(request, TID):
    todo = TemporaryTagPermission.objects.get(id = TID)

    if request.method == 'PUT':
        data = {}
        serializer = TtpSerializers(todo, data = request.data)
        if serializer.is_valid():
            serializer.save()
            data['status'] = 'updated'
            return Response(data = data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_404_NOT_FOUND)

# Delete Data
@api_view(['DELETE'])
def delete_requestlist(request,TID):
    todo = TemporaryTagPermission.objects.get(id=TID)

    if request.method == 'DELETE':
        delete = todo.delete()
        data = {}
        if delete:
            data ['status'] = 'deleted'
            statuscode = status.HTTP_200_OK
        else:
            data['status'] = 'failed'
            statuscode = status.HTTP_400_BAD_REQUEST
        return Response(data=data, status=statuscode)

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