[watcher:remotecv]
cmd = remotecv --host {{REDIS_HOST | default('redis')}} --port {{REDIS_PORT | default(6379)}} --database {{REDIS_DATABASE | default(0)}} -l {{LOG_LEVEL | default('INFO')}}
numprocesses = 1
use_sockets = False
uid = remotecv
gid = remotecv
working_dir = /code
virtualenv = /code/env
copy_env = True
autostart = True
