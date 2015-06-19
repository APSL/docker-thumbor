[watcher:thumbor]
cmd = thumbor --port=8000 --conf=/tmp/thumbor.conf
numprocesses = 1
use_sockets = False
uid = thumbor
gid = thumbor
working_dir = /code
virtualenv = /code/env
copy_env = True
autostart = True
