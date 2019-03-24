from rest_framework.views import exception_handler
from rest_framework.exceptions import APIException

class StartTilError(APIException):
    status_code = 400
    default_detail = 'Til time is earlier then the start time!'
    default_code = 'start_til_error'

class TimeOccupiedError(APIException):
    status_code = 400
    default_detail = 'Chosen time is already occupied by other scedule!'
    default_code = 'time_occupied_error'
