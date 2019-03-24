from rest_framework import serializers
from meetings.models import Meeting
from django.contrib.auth.models import User

class MeetingSerializer(serializers.ModelSerializer):
    user = serializers.ReadOnlyField(source='user.id')
    created = serializers.DateTimeField(format="%Y-%m-%dT%H:%M:%S%z", read_only=True)
    sinceWhen = serializers.DateTimeField(format="%Y-%m-%dT%H:%M:%S%z")
    tilWhen = serializers.DateTimeField(format="%Y-%m-%dT%H:%M:%S%z")

    class Meta:
        model = Meeting
        fields = ('id', 'created', 'sinceWhen', 'tilWhen', 'user')
        read_only_fields = ('id', 'created', 'user')

class UserSerializer(serializers.ModelSerializer):
    meetings = serializers.PrimaryKeyRelatedField(many=True, queryset=Meeting.objects.all())

    class Meta:
        model = User
        fields = ('id', 'username', 'meetings')

