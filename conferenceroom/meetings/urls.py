from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns

from meetings import views

urlpatterns = format_suffix_patterns([
    path('meetings/',
         views.MeetingList.as_view(),
         name='meeting-list'),
    path('meetings/<int:pk>/', 
         views.MeetingDetail.as_view(),
         name='meeting-detail'),
    path('users/',
         views.UserList.as_view(),
         name='user-list'),
    path('users/<int:pk>/',
         views.UserDetail.as_view(),
         name='user-detail')
])
