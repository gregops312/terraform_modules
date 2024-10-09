#!/bin/bash

set -eo xtrace

readonly LOGFILE=/var/log/uptake.log

nginx_index() {
  # https://stackoverflow.com/questions/52048407/how-to-have-a-literal-string-of-something-in-a-template-data-file
  # https://stackoverflow.com/questions/37876778/escape-dollar-sign-in-string-by-shell-script
  cat > /usr/share/nginx/html/index.html <<- EOM
  <!DOCTYPE html>
  <html>
  <head>
      <title>Welcome to Super Sweet Marketing Site!!!</title>
      <style>
          body {
              width: 35em;
              margin: 0 auto;
              font-family: Tahoma, Verdana, Arial, sans-serif;
          }
      </style>
  </head>
  <body>
  <h1>Welcome to web 2.0!</h1>
  <p>If you see this page, you are master of the internet.</p>

  <p><em>Thank you for 2.0ing the web.</em></p>
  </body>
  </html>
EOM
}

nginx_conf() {
  cat > /etc/nginx/nginx.conf <<- EOM
    user nginx;
    worker_processes auto;
    error_log /var/log/nginx/error.log;
    pid /run/nginx.pid;

    # Load dynamic modules. See /usr/share/doc/nginx/README.dynamic.
    include /usr/share/nginx/modules/*.conf;

    events {
        worker_connections 1024;
    }

    http {
        log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                        '$status $body_bytes_sent "$http_referer" '
                        '"$http_user_agent" "$http_x_forwarded_for"';

        access_log  /var/log/nginx/access.log  main;

        sendfile            on;
        tcp_nopush          on;
        tcp_nodelay         on;
        keepalive_timeout   65;
        types_hash_max_size 4096;

        include             /etc/nginx/mime.types;
        default_type        application/octet-stream;

        # Load modular configuration files from the /etc/nginx/conf.d directory.
        # See http://nginx.org/en/docs/ngx_core_module.html#include
        # for more information.
        include /etc/nginx/conf.d/*.conf;
        include /etc/nginx/sites-available/*;
    }
EOM
}

site() {
  cat > /etc/nginx/sites-available/website.com <<- EOM
    server {
            listen       80;
            listen       [::]:80;
            server_name  _;
            root         /usr/share/nginx/html;

            # Load configuration files for the default server block.
            include /etc/nginx/default.d/*.conf;

            error_page 404 /404.html;
                location = /40x.html {
            }

            error_page 500 502 503 504 /50x.html;
                location = /50x.html {
            }
        }
    # TODO
    1. Generate certs for super sweet marketing site
    2. Enable https
    3. ???
    4. Profit
EOM
}

sys_load_check() {
  mkdir /opt/uptake

  cat > /opt/uptake/sys_load_check.py <<- EOM
#!/usr/bin/env python

# Alert CRITICAL if 1 minute load is above 1
from os import getloadavg

load1, load5, load15 = getloadavg()

if load1 < 1:
    print "CRITICAL"
else:
    print "NORMAL"
EOM
}

super_app() {
  cat > /opt/uptake/super_app.py <<- EOM
#!/usr/bin/env python
import time
import argparse
import logging


def main():

    parser = argparse.ArgumentParser()
    parser.add_argument("-l", "--logdir", nargs='?', const=1, default="/var/log/uptake.log")
    args = parser.parse_args()

    logging.basicConfig(filename=args.logdir, format='%(asctime)s %(message)s', level=logging.INFO)

    logging.info('Application Started')

    while True:
        logging.info('Amazing things happening here.')
        time.sleep(10)

if __name__ == '__main__':
    main()
EOM
}

# Special AWS logging setup https://aws.amazon.com/premiumsupport/knowledge-center/ec2-linux-log-user-data/
exec > >(tee /var/log/user-data.log) 2>&1

echo "Script Begin"

# Basics
# useradd -m uptakeadmin
# sudo -u uptakeadmin ssh-keygen -b 2048 -t rsa -f /home/uptakeadmin/.ssh/id_rsa -q -N ""
# sudo -u uptakeadmin cat /home/uptakeadmin/.ssh/id_rsa.pub > /home/uptakeadmin/.ssh/authorized_keys
sudo -u ec2-user ssh-keygen -b 2048 -t rsa -f /home/ec2-user/.ssh/id_rsa -q -N ""
sudo -u ec2-user cat /home/ec2-user/.ssh/id_rsa.pub >> /home/ec2-user/.ssh/authorized_keys

# S2
sudo amazon-linux-extras install -y nginx1
mkdir /etc/nginx/sites-available
nginx_index
nginx_conf
site
systemctl enable nginx
systemctl start nginx || true

# S3
sys_load_check

# S4
super_app
touch $${LOGFILE}
dd if=/dev/zero of=$${LOGFILE} bs=128M count=180
for i in {1..4};do
  python /opt/uptake/super_app.py --logdir $${LOGFILE} &
  disown -h %1
done

# End
echo "Script Complete!!!"
