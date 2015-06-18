[watcher:thumbor]
cmd = celery 
args = --host {{REDIS_HOST | default('main')}} --port={{ REDIS_PORT | default('6379')}} --database {{ REDIS_DATABASE | default('0')}} -l INFO
numprocesses = 1
use_sockets = False
uid = thumbor
gid = thumbor
working_dir = /code
virtualenv = /code/env
copy_env = True
{% if (RUN_WEB | default('True')) == 'False' %}
autostart = False
{% endif %}

[socket:thumbor]
host = 0.0.0.0
port = 8000
