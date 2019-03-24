from django.db import models


class Meeting(models.Model):
    created = models.DateTimeField(auto_now_add=True)
    sinceWhen = models.DateTimeField()
    tilWhen = models.DateTimeField()
# Not sure what does it do on below....    
    user = models.ForeignKey('auth.User', related_name='meetings', on_delete=models.CASCADE)
    highlighted = models.TextField()

    class Meta:
        ordering = ('id',)


# Create your models here.
