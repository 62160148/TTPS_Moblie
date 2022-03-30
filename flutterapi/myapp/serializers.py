from rest_framework import serializers
from .models import TemporaryTagPermission

class TtpSerializers(serializers.ModelSerializer):
    class Meta:
        model = TemporaryTagPermission
        fields = ('id', 'startdate', 'enddate', 'item', 'reason', 'tel', 'supervisor', 'approveplant')