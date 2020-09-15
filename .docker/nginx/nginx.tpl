server {
  listen  80;
  index index.php index.html;
  root  /var/www/public;

  #access_log /var/log/nginx/example.journaldev.com-access.log;
  #error_log  /var/log/nginx/example.journaldev.com-error.log error;

  location ~ \.php$ {
    try_files $uri =404;
    fastcgi_split_path_info ^(.+\.php)(/.+)$;
    fastcgi_pass {{ .Env.HOST }}:{{ .Env.PORT }};
    fastcgi_index index.php;
    include fastcgi_params;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    fastcgi_param PATH_INFO $fastcgi_path_info;
  }

  location / {
    try_files $uri $uri/ /index.php$query_string;
    gzip_static on;
  }
}