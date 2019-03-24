from meetings.models import Meeting
from meetings.serializers import MeetingSerializer
from django.contrib.auth.models import User
from meetings.serializers import UserSerializer

from meetings.permissions import IsOwner

import datetime
import pytz

from rest_framework.response import Response
from rest_framework import status
from rest_framework import generics
from rest_framework import permissions

def parsing_date(date):
    try:
        return datetime.datetime.strptime(date, '%Y-%m-%dT%H:%M:%S%z')
    except ValueError:
        pass
    
    try:
        return datetime.datetime.strptime(date, '%Y-%m-%dT%H:%M').replace(tzinfo=pytz.UTC)
    except ValueError:
        pass
    try:
        tmp = date.rfind(':')
        return datetime.datetime.strptime(date[:tmp] + date[tmp+1:], '%Y-%m-%dT%H:%M:%S%z')
    except ValueError:
        return None
    

class MeetingList(generics.ListCreateAPIView):
    # Overrided
    def perform_create(self, serializer):
        serializer.save(user=self.request.user)
    
    # Overrided
    def post(self, request, *args, **kwargs):
        data = request.data
        since = parsing_date(data['sinceWhen'])
        til = parsing_date(data['tilWhen'])
        
        if since == None or til == None:
            return Response(status=status.HTTP_400_BAD_REQUEST)
        
        if since > til:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        for item in Meeting.objects.all():
            if not (til <= item.sinceWhen or since >= item.tilWhen):
                return Response(status=status.HTTP_400_BAD_REQUEST)
        return self.create(request, *args, **kwargs)


    permission_classes = (permissions.IsAuthenticatedOrReadOnly,)
    queryset = Meeting.objects.all()
    serializer_class = MeetingSerializer

class MeetingDetail(generics.RetrieveUpdateDestroyAPIView):
    # Overrided
    def put(self, request, *args, **kwargs):
        data = request.data
        since = parsing_date(data['sinceWhen'])
        til = parsing_date(data['tilWhen'])
        
        if since == None or til == None:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        if since >= til:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        for item in Meeting.objects.all():
            if (int)(kwargs['pk']) == item.id:
                continue
            if not (til <= item.sinceWhen or since >= item.tilWhen):
                return Response(status=status.HTTP_400_BAD_REQUEST)
        return self.update(request, *args, **kwargs)


    permission_classes = (permissions.IsAuthenticatedOrReadOnly,
                          IsOwner)
    queryset = Meeting.objects.all()
    serializer_class = MeetingSerializer

class UserList(generics.ListAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer

class UserDetail(generics.RetrieveAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer
# Create your views here
