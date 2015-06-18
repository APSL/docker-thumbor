[watcher:nginx]
cmd = /usr/sbin/nginx -c /etc/nginx/nginx.conf
numprocesses = 1
use_sockets = False
copy_env = True
singleton = True
autostart = {{ RUN_WEB | default('True') }}
