FROM ubuntu:latest

RUN apt-get -y update
RUN apt-get -y install git curl gcc libpcre3 libpcre3-dev libssl-dev zlib1g zlib1g-dev make tar

WORKDIR /build-nginx

RUN curl -L -O https://nginx.org/download/nginx-1.24.0.tar.gz
RUN tar xvf nginx-1.24.0.tar.gz
RUN git clone https://github.com/winshining/nginx-http-flv-module.git

WORKDIR /build-nginx/nginx-1.24.0
RUN ./configure --with-cc-opt='-g -O2 -fPIC' --with-ld-opt='-Wl,-Bsymbolic-functions -flto=auto -ffat-lto-objects -flto=auto -Wl,-z,relro -Wl,-z,now -fPIC' --prefix=/usr/share/nginx --conf-path=/etc/nginx/nginx.conf --http-log-path=/var/log/nginx/access.log --error-log-path=/var/log/nginx/error.log --lock-path=/var/lock/nginx.lock --pid-path=/run/nginx.pid --with-compat --with-debug --with-pcre-jit --with-http_ssl_module --with-http_stub_status_module --with-http_realip_module --with-http_auth_request_module --with-http_v2_module --with-http_dav_module --with-http_slice_module --with-threads --with-http_addition_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_sub_module --add-module=/build-nginx/nginx-http-flv-module
RUN make
RUN make install


STOPSIGNAL SIGQUIT

COPY nginx.conf /etc/nginx/nginx.conf
CMD ["/usr/share/nginx/sbin/nginx", "-g", "daemon off;"]


