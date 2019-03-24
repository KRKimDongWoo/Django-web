# POST new meetings
http -v -a zx:123 POST http://127.0.0.1:8000/meetings/ sinceWhen='2019-11-10T02:00:00+09:00' tilWhen='2019-11-10T03:00:00+09:00'
http -v -a test:123 POST http://127.0.0.1:8000/meetings/ sinceWhen='2019-10-10T02:00:00+09:00' tilWhen='2019-10-10T10:00:00+09:00'
http -v -a test2:123 POST http://127.0.0.1:8000/meetings/ sinceWhen='2019-11-12T02:00:00+09:00' tilWhen='2019-11-12T10:00:00+09:00'
http -v -a zx:123 POST http://127.0.0.1:8000/meetings/ sinceWhen='2019-11-10T17:00:00+09:00' tilWhen='2019-11-10T20:00:00+09:00'
http -v -a test:123 POST http://127.0.0.1:8000/meetings/ sinceWhen='2019-11-10T03:00:00+09:00' tilWhen='2019-11-10T04:00:00+09:00'
http -v -a test2:123 POST http://127.0.0.1:8000/meetings/ sinceWhen='2019-11-10T04:00:00+09:00' tilWhen='2019-11-10T05:00:00+09:00'
http -v -a test:123 POST http://127.0.0.1:8000/meetings/ sinceWhen='2019-11-10T07:00:00+09:00' tilWhen='2019-11-10T08:00:00+09:00'

# Check if meetings are entered correctly
http -v GET http://127.0.0.1:8000/meetings/

# These should not work
# Unauthorized
http -v POST http://127.0.0.1:8000/meetings/ sinceWhen='2019-11-10T07:00:00+09:00' tilWhen='2019-11-10T08:00:00+09:00'
http -v POST http://127.0.0.1:8000/meetings/ sinceWhen='2019-11-13T07:00:00+09:00' tilWhen='2019-11-13T08:00:00+09:00'

# sinceWhen > tilWhen
http -v -a zx:123 POST http://127.0.0.1:8000/meetings/ sinceWhen='2019-11-12T07:00:00+09:00' tilWhen='2019-11-10T08:00:00+09:00'
http -v -a test:123 POST http://127.0.0.1:8000/meetings/ sinceWhen='2019-11-10T08:00:00+09:00' tilWhen='2019-11-10T08:00:00+09:00'
http -v -a test2:123 POST http://127.0.0.1:8000/meetings/ sinceWhen='2019-11-10T09:00:00+09:00' tilWhen='2019-11-10T08:00:00+09:00'

# Overlapping Times
http -v -a test:123 POST http://127.0.0.1:8000/meetings/ sinceWhen='2019-11-10T17:00:00+09:00' tilWhen='2019-11-10T20:00:00+09:00'
http -v -a test:123 POST http://127.0.0.1:8000/meetings/ sinceWhen='2019-11-10T16:00:00+09:00' tilWhen='2019-11-10T21:00:00+09:00'
http -v -a test:123 POST http://127.0.0.1:8000/meetings/ sinceWhen='2019-11-10T18:00:00+09:00' tilWhen='2019-11-10T21:00:00+09:00'
http -v -a test:123 POST http://127.0.0.1:8000/meetings/ sinceWhen='2019-11-10T16:00:00+09:00' tilWhen='2019-11-10T19:00:00+09:00'

# GET meeting info by id
http -v -a zx:123 GET http://127.0.0.1:8000/meetings/1/
http -v -a zx:123 GET http://127.0.0.1:8000/meetings/4/
http -v -a test:123 GET http://127.0.0.1:8000/meetings/2/
http -v -a test:123 GET http://127.0.0.1:8000/meetings/5/
http -v -a test:123 GET http://127.0.0.1:8000/meetings/7/
http -v -a test2:123 GET http://127.0.0.1:8000/meetings/3/
http -v -a test2:123 GET http://127.0.0.1:8000/meetings/6/

# These should not work
# Unauthorized
http -v GET http://127.0.0.1:8000/meetings/1/
http -v GET http://127.0.0.1:8000/meetings/2/
http -v GET http://127.0.0.1:8000/meetings/7/
http -v -a zx:123 GET http://127.0.0.1:8000/meetings/2/
http -v -a zx:123 GET http://127.0.0.1:8000/meetings/6/
http -v -a test:123 GET http://127.0.0.1:8000/meetings/3/
http -v -a test:123 GET http://127.0.0.1:8000/meetings/1/
http -v -a test2:123 GET http://127.0.0.1:8000/meetings/2/

# PUT meeting info
http -v -a zx:123 PUT http://127.0.0.1:8000/meetings/1/ sinceWhen='2018-11-10T02:00:00+09:00' tilWhen='2018-11-10T03:00:00+09:00'
http -v -a test:123 PUT http://127.0.0.1:8000/meetings/2/ sinceWhen='2018-10-10T02:00:00+09:00' tilWhen='2018-10-10T10:00:00+09:00'
http -v -a test2:123 PUT http://127.0.0.1:8000/meetings/3/ sinceWhen='2018-11-12T02:00:00+09:00' tilWhen='2018-11-12T10:00:00+09:00'

# Check edited times
http -v GET http://127.0.0.1:8000/meetings/

# These should not work
# Unauthorized
http -v PUT http://127.0.0.1:8000/meetings/1/ sinceWhen='2018-11-10T02:00:00+09:00' tilWhen='2018-11-10T03:00:00+09:00'
http -v PUT http://127.0.0.1:8000/meetings/3/ sinceWhen='2018-11-10T02:00:00+09:00' tilWhen='2018-11-10T03:00:00+09:00'
http -v -a test:123 PUT http://127.0.0.1:8000/meetings/1/ sinceWhen='2018-10-10T02:00:00+09:00' tilWhen='2018-10-10T10:00:00+09:00'
http -v -a test2:123 PUT http://127.0.0.1:8000/meetings/2/ sinceWhen='2018-11-12T02:00:00+09:00' tilWhen='2018-11-12T10:00:00+09:00'

# sinceWhen > tilWhen
http -v -a test:123 PUT http://127.0.0.1:8000/meetings/2/ sinceWhen='2019-10-10T02:00:00+09:00' tilWhen='2018-10-10T10:00:00+09:00'
http -v -a test2:123 PUT http://127.0.0.1:8000/meetings/3/ sinceWhen='2019-10-10T02:00:00+09:00' tilWhen='2018-10-10T10:00:00+09:00'

# Overlapping Times
http -v -a zx:123 PUT http://127.0.0.1:8000/meetings/4/ sinceWhen='2019-11-10T03:00:00+09:00' tilWhen='2019-11-10T04:00:00+09:00'
http -v -a zx:123 PUT http://127.0.0.1:8000/meetings/4/ sinceWhen='2019-11-10T03:00:00+09:00' tilWhen='2019-11-10T06:00:00+09:00'
http -v -a test:123 PUT http://127.0.0.1:8000/meetings/5/ sinceWhen='2019-11-10T03:00:00+09:00' tilWhen='2019-11-10T23:00:00+09:00'

# DELETE meeting info
http -v -a zx:123 DELETE http://127.0.0.1:8000/meetings/1/
http -v -a test:123 DELETE http://127.0.0.1:8000/meetings/2/
http -v -a test2:123 DELETE http://127.0.0.1:8000/meetings/3/

# Check deletion
http -v GET http://127.0.0.1:8000/meetings/

# These should not work
# Unauthorized
http -v DELETE http://127.0.0.1:8000/meetings/4/
http -v DELETE http://127.0.0.1:8000/meetings/5/
http -v DELETE http://127.0.0.1:8000/meetings/7/
http -v -a zx:123 DELETE http://127.0.0.1:8000/meetings/5/
http -v -a test:123 DELETE http://127.0.0.1:8000/meetings/6/
http -v -a test2:123 DELETE http://127.0.0.1:8000/meetings/4/

# Not Found
http -v -a zx:123 DELETE http://127.0.0.1:8000/meetings/1/
http -v -a zx:123 DELETE http://127.0.0.1:8000/meetings/2/


# GET user list
http -v GET http://127.0.0.1:8000/users/

# GET user by id
http -v GET http://127.0.0.1:8000/users/1/
http -v GET http://127.0.0.1:8000/users/2/
http -v GET http://127.0.0.1:8000/users/3/


# Incorrect form
http -v -a zx:123 POST http://127.0.0.1:8000/meetings/ sinceWhen='2019-11-10T02:00:00+09:00' tilWhen='2019-1110T03:00:0009:0'
