from rest_framework import serializers
from myapp.models import TemporaryTagPermission

class TtpSerializers(serializers.ModelSerializer):
    class Meta:
        model = TemporaryTagPermission
        field = ('id', 'startdate', 'enddate', 'item', 'reason', 'tel', 'supervisor', 'approveplant')