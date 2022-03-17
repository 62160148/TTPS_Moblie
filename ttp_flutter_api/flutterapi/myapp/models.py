from django.db import models

# Create your models here.
class TemporaryTagPermission(models.Model):
    startdate = models.TextField(null=False, blank=False)
    enddate = models.TextField(null=False, blank=False)    
    item = models.CharField(max_length=100)
    reason = models.TextField(null=True, blank=True)
    tel = models.CharField(max_length=10)
    supervisor = models.TextField(null=True, blank=True)
    approveplant = models.TextField(null=True, blank=True)
    
    def __str__(self):
        return self.requestdate
