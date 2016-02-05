[watcher:thumbor]
cmd = thumbor
args = --conf=/usr/src/app/thumbor.conf --fd $(circus.sockets.thumbor)
numprocesses = {{ THUMBOR_NUM_PROCESSES | default(8) }}
use_sockets = True
working_dir = /usr/src/app
copy_env = True
autostart = True

[socket:thumbor]
host = 0.0.0.0
port = {{ THUMBOR_PORT | default(8000) }}
