[watcher:remotecv]
cmd = remotecv
args = --host {{REDIS_HOST | default('redis')}} --port {{REDIS_PORT | default(6379)}} --database {{REDIS_DATABASE | default(0)}} -l {{LOG_LEVEL | default('INFO')}}
numprocesses = {{ REMOTECV_NUM_PROCESSES | default(2) }}
use_sockets = True
working_dir = /usr/src/app
copy_env = True
autostart = True
