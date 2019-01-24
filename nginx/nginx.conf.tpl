
daemon  on;  # daemon on | off; Default: daemon on; Context: main -- Determines whether nginx should become a daemon. Mainly used during development.
user  www;  # user user [group]; Default: user nobody nobody; Context: main -- Defines user and group credentials used by worker processes. If group is omitted, a group whose name equals that of user is used.
# master_process on;  # master_process on | off; Default: master_process on; Context: main -- Determines whether worker processes are started. This directive is intended for nginx developers.
worker_processes  2;  # worker_processes number | auto; Default: worker_processes 1; Context: main -- Defines the number of worker processes.
# worker_cpu_affinity  # worker_cpu_affinity cpumask ...; worker_cpu_affinity auto [cpumask]; Default: --; Context: main -- Binds worker processes to the sets of CPUs.
# worker_priority 0;  # worker_priority number; Default: worker_priority 0; Context: main -- Defines the scheduling priority for worker processes like it is done by the nice command: a negative number means higher priority. Allowed range normally varies from -20 to 20.
# worker_rlimit_core;  # worker_rlimit_core size; Default: --; Context: main -- Changes the limit on the largest size of a core file (RLIMIT_CORE) for worker processes.
# worker_rlimit_nofile;  # worker_rlimit_nofile number; Default: --; Context: main -- Changes the limit on the maximum number of open files (RLIMIT_NOFILE) for worker processes.
# worker_shutdown_timeout;  # worker_shutdown_timeout time; Default: --; Context: main -- Configures a timeout for a graceful shutdown of worker processes. When the time expires, nginx will try to close all the connections currently open to facilitate shutdown.

pid  /run/nginx.pid;  # pid file; Default: pid logs/nginx.pid; Context: main -- Defines a file that will store the process ID of the main process.
lock_file  /run/nginx.lock;  # lock_file file; Default: lock_file logs/nginx.lock; Context: main -- nginx uses the locking mechanism to implement accept_mutex and serialize access to shared memory.

# thread_pool  # thread_pool name threads=number [max_queue=number]; Default: thread_pool default threads=32 max_queue=65536; Context: main -- Defines named thread pools used for multi-threaded reading and sending of files without blocking worker processes.

# env  TZ;  # env variable[=value]; Default: env TZ; Context: main -- By default, nginx removes all environment variables inherited from its parent process except the TZ variable. This directive allows preserving some of the inherited variables, changing their values, or creating new environment variables.
# timer_resolution;  # timer_resolution interval; Default: --; Context: main -- Reduces timer resolution in worker processes, thus reducing the number of gettimeofday() system calls made. By default, gettimeofday() is called each time a kernel event is received. With reduced resolution, gettimeofday() is only called once per specified interval.
# pcre_jit  off;  # pcre_jit on | off; Default: pcre_jit off; Context: main -- Enables or disables the use of “just-in-time compilation” (PCRE JIT) for the regular expressions known by the time of configuration parsing.
# ssl_engine;  # ssl_engine device; Default: --; Context: main -- Defines the name of the hardware SSL accelerator.

# load_module;  # load_module file; Default: --; Context: main -- Loads a dynamic module.

# debug_points;  # debug_points abort | stop; Default: --; Context: main -- This directive is used for debugging. When internal error is detected, e.g. the leak of sockets on restart of working processes, enabling debug_points leads to a core file creation (abort) or to stopping of a process (stop) for further analysis using a system debugger.
# working_directory;  # working_directory directory; Default: --; Context: main -- Defines the current working directory for a worker process. It is primarily used when writing a core-file, in which case a worker process should have write permission for the specified directory.
error_log  /var/log/nginx/error.log  error;  # error_log file [level]; Default: error_log logs/error.log error; Context: main, http, mail, stream, server, location -- Configures logging. Several logs can be specified on the same level (1.5.2). If on the main configuration level writing a log to a file is not explicitly defined, the default file will be used.
error_log  /var/log/nginx/info.log  info;

events {
    # use;  # use method; Default: --; Context: events -- Specifies the connection processing method to use. There is normally no need to specify it explicitly, because nginx will by default use the most efficient method.
    accept_mutex  on;  # accept_mutex on | off; Default: accept_mutex off; Context: events -- If accept_mutex is enabled, worker processes will accept new connections by turn. Otherwise, all worker processes will be notified about new connections, and if volume of new connections is low, some of the worker processes may just waste system resources.
    accept_mutex_delay  500ms;  # accept_mutex_delay time; Default: accept_mutex_delay 500ms; Context: events -- If accept_mutex is enabled, specifies the maximum time during which a worker process will try to restart accepting new connections if another worker process is currently accepting new connections.
    multi_accept  on;  # multi_accept on | off; Default: multi_accept off; Context: events -- If multi_accept is disabled, a worker process will accept one new connection at a time. Otherwise, a worker process will accept all new connections at a time.
    worker_connections  1024;  # worker_connections number; Default: worker_connections 512; Context: events -- Sets the maximum number of simultaneous connections that can be opened by a worker process.
    # worker_aio_requests  32;  # worker_aio_requests number; Default: worker_aio_requests 32; Context: events -- When using aio with the epoll connection processing method, sets the maximum number of outstanding asynchronous I/O operations for a single worker process.
    # debug_connection;  # debug_connection address | CIDR | unix:; Default: --; Context: events -- Enables debugging log for selected client connections. Other connections will use logging level set by the error_log directive.
}

# include;  # include file | mask; Default: --; Context: any -- Includes another file, or files matching the specified mask, into configuration. Included files should consist of syntactically correct directives and blocks.

http {
    # types  {}  # types { ... } Default: types {text/html html; image/gif gif; image/jpeg jpg;} Context: http, server, location -- Maps file name extensions to MIME types of responses. Extensions are case-insensitive.
    # types_hash_bucket_size  64;  # types_hash_bucket_size size; Default: types_hash_bucket_size 64; Context: http, server, location -- Sets the bucket size for the types hash tables.
    # types_hash_max_size  1024;  # types_hash_max_size size; Default: types_hash_max_size 1024; Context: http, server, location -- Sets the maximum size of the types hash tables.
    include  mime.types;
    default_type  application/octet-stream;  # default_type mime-type; Default: default_type text/plain; Context: 	http, server, location -- Defines the default MIME type of a response.

    # server_names_hash_bucket_size  64;  # server_names_hash_bucket_size size; Default: server_names_hash_bucket_size 32|64|128; Context: http -- Sets the bucket size for the server names hash tables. The default value depends on the size of the processor’s cache line.
    # server_names_hash_max_size  512;  # server_names_hash_max_size size; Default: server_names_hash_max_size 512; Context: http -- Sets the maximum size of the server names hash tables.
    # variables_hash_bucket_size  64;  # variables_hash_bucket_size size; Default: variables_hash_bucket_size 64; Context: http -- Sets the bucket size for the variables hash table.
    # variables_hash_max_size  1024;  # variables_hash_max_size size; Default: variables_hash_max_size 1024; Context: http -- Sets the maximum size of the variables hash table.

    # resolver;  # resolver address ... [valid=time] [ipv6=on|off]; Default: --; Context: http, server, location -- Configures name servers used to resolve names of upstream servers into addresses
    # resolver_timeout  30s;  # resolver_timeout time; Default: resolver_timeout 30s; Context: http, server, location -- Sets a timeout for name resolution

    # absolute_redirect  on;  # absolute_redirect on | off; Default: absolute_redirect on; Context: http, server, location -- If disabled, redirects issued by nginx will be relative.
    # server_name_in_redirect  off;  # server_name_in_redirect on | off; Default: server_name_in_redirect off; Context: http, server, location -- Enables or disables the use of the primary server name, specified by the server_name directive, in absolute redirects issued by nginx.
    # port_in_redirect  on;  # port_in_redirect on | off; Default: port_in_redirect on; Context: http, server, location -- Enables or disables specifying the port in absolute redirects issued by nginx.

    # satisfy  all;  # satisfy all | any; Default: satisfy all; Context: http, server, location -- Allows access if all (all) or at least one (any) of the ngx_http_access_module, ngx_http_auth_basic_module, ngx_http_auth_request_module, or ngx_http_auth_jwt_module modules allow access.

    # connection_pool_size  256;  # connection_pool_size size; Default: connection_pool_size 256|512; Context: http, server -- Allows accurate tuning of per-connection memory allocations. This directive has minimal impact on performance and should not generally be used.
    # lingering_close  on;  # lingering_close off | on | always; Default: lingering_close on; Context: http, server, location -- Controls how nginx closes client connections.
    # lingering_time  30s;  # lingering_time time; Default: lingering_time 30s; Context: http, server, location -- When lingering_close is in effect, this directive specifies the maximum time during which nginx will process (read and ignore) additional data coming from a client. After that, the connection will be closed, even if there will be more data.
    # lingering_timeout  5s;  # lingering_timeout time; Default: lingering_timeout 5s; Context: http, server, location -- When lingering_close is in effect, this directive specifies the maximum waiting time for more client data to arrive.

    # keepalive_disable  msie6;  # keepalive_disable none | browser ...; Default: keepalive_disable msie6; Context: http, server, location -- Disables keep-alive connections with misbehaving browsers.
    # keepalive_requests  100;  # keepalive_requests number; Default: keepalive_requests 100; Context: http, server, location -- Sets the maximum number of requests that can be served through one keep-alive connection. After the maximum number of requests are made, the connection is closed.
    # keepalive_timeout  75s;  # keepalive_timeout timeout [header_timeout]; Default: keepalive_timeout 75s; Context: http, server, location -- The first parameter sets a timeout during which a keep-alive client connection will stay open on the server side. The zero value disables keep-alive client connections. The optional second parameter sets a value in the “Keep-Alive: timeout=time” response header field.

    # reset_timedout_connection  off;  # reset_timedout_connection on | off; Default: reset_timedout_connection off; Context: http, server, location -- Enables or disables resetting timed out connections.

    # request_pool_size  4k;  # request_pool_size size; Default: request_pool_size 4k; Context: http, server -- Allows accurate tuning of per-request memory allocations. This directive has minimal impact on performance and should not generally be used.

    # client_header_buffer_size  1k;  # client_header_buffer_size size; Default: client_header_buffer_size 1k; Context: http, server -- Sets buffer size for reading client request header.
    # large_client_header_buffers  4  8k;  # large_client_header_buffers number size; Default: large_client_header_buffers 4 8k; Context: http, server -- Sets the maximum number and size of buffers used for reading large client request header.
    # client_header_timeout  60s;  # client_header_timeout time; Default: client_header_timeout 60s; Context: http, server -- Defines a timeout for reading client request header. If a client does not transmit the entire header within this time, the request is terminated with the 408 (Request Time-out) error.
    # ignore_invalid_headers  on;  # ignore_invalid_headers on | off; Default: ignore_invalid_headers on; Context: http, server -- Controls whether header fields with invalid names should be ignored.
    # underscores_in_headers  off;  # underscores_in_headers on | off; Default: underscores_in_headers off; Context: http, server -- Enables or disables the use of underscores in client request header fields.

    # client_body_buffer_size  8k;  # client_body_buffer_size size; Default: client_body_buffer_size 8k|16k; Context: http, server, location -- Sets buffer size for reading client request body.
    # client_body_temp_path  client_body_temp;  # client_body_temp_path path [level1 [level2 [level3]]]; Default: client_body_temp_path client_body_temp; Context: http, server, location -- Defines a directory for storing temporary files holding client request bodies.
    # client_body_timeout  60s;  # client_body_timeout time; Default: client_body_timeout 60s; Context: http, server, location -- Defines a timeout for reading client request body. The timeout is set only for a period between two successive read operations, not for the transmission of the whole request body.
    # client_max_body_size  1m;  # client_max_body_size size; Default: client_max_body_size 1m; Context: http, server, location -- Sets the maximum allowed size of the client request body, specified in the “Content-Length” request header field.
    # client_body_in_file_only  off;  # client_body_in_file_only on | clean | off; Default: client_body_in_file_only off; Context: http, server, location -- Determines whether nginx should save the entire client request body into a file.
    # client_body_in_single_buffer  off;  # client_body_in_single_buffer on | off; Default: client_body_in_single_buffer off; Context: http, server, location -- Determines whether nginx should save the entire client request body in a single buffer.

    root  html;  # root path; Default: root html; Context: http, server, location, if in location -- Sets the root directory for requests.
    disable_symlinks  off;  # disable_symlinks off; | disable_symlinks on | if_not_owner [from=part]; Default: disable_symlinks off; Context: http, server, location -- Determines how symbolic links should be treated when opening files

    # open_file_cache  off;  # open_file_cache off; | open_file_cache max=N [inactive=time]; Default: open_file_cache off; Context: http, server, location
    # open_file_cache_errors  off;  # open_file_cache_errors on | off; Default: open_file_cache_errors off; Context: http, server, location -- Enables or disables caching of file lookup errors by open_file_cache.
    # open_file_cache_min_uses  1;  # open_file_cache_min_uses number; Default: open_file_cache_min_uses 1; Context: http, server, location -- Sets the minimum number of file accesses during the period configured by the inactive parameter of the open_file_cache directive, required for a file descriptor to remain open in the cache.
    # open_file_cache_valid  60s;  # open_file_cache_valid time; Default: open_file_cache_valid 60s; Context: http, server, location -- Sets a time after which open_file_cache elements should be validated.

    # output_buffers  2  32k;  # output_buffers number size; Default: output_buffers 2 32k; Context: http, server, location -- Sets the number and size of the buffers used for reading a response from a disk.
    # limit_rate  0;  # limit_rate rate; Default: limit_rate 0; Context: http, server, location, if in location -- Limits the rate of response transmission to a client. The rate is specified in bytes per second. The zero value disables rate limiting.
    # limit_rate_after  0;  # limit_rate_after size; Default: limit_rate_after 0; Context: http, server, location, if in location -- Sets the initial amount after which the further transmission of a response to a client will be rate limited.
    # send_timeout  60s;  # send_timeout time; Default: send_timeout 60s; Context: http, server, location -- Sets a timeout for transmitting a response to the client. The timeout is set only between two successive write operations, not for the transmission of the whole response.
    # subrequest_output_buffer_size  4k;  # subrequest_output_buffer_size size; Default: subrequest_output_buffer_size 4k|8k; Context: http, server, location -- Sets the size of the buffer used for storing the response body of a subrequest.

    # aio  off;  # aio on | off | threads[=pool]; Default: aio off; Context: http, server, location -- Enables or disables the use of asynchronous file I/O (AIO) on FreeBSD and Linux.
    # aio_write  off;  # aio_write on | off; Default: aio_write off; Context: http, server, location -- If aio is enabled, specifies whether it is used for writing files. Currently, this only works when using aio threads and is limited to writing temporary files with data received from proxied servers.
    # directio  off;  # directio size | off; Default: directio off; Context: http, server, location -- Enables the use of the O_DIRECT flag (FreeBSD, Linux), the F_NOCACHE flag (macOS), or the directio() function (Solaris), when reading files that are larger than or equal to the specified size. The directive automatically disables (0.7.15) the use of sendfile for a given request.
    # directio_alignment  512;  # directio_alignment size; Default: directio_alignment 512; Context: http, server, location -- Sets the alignment for directio. In most cases, a 512-byte alignment is enough. However, when using XFS under Linux, it needs to be increased to 4K.
    # sendfile  on;  # sendfile on | off; Default: sendfile off; Context: http, server, location, if in location -- Enables or disables the use of sendfile()
    # sendfile_max_chunk  0;  # sendfile_max_chunk size; Default: sendfile_max_chunk 0; Context: http, server, location -- When set to a non-zero value, limits the amount of data that can be transferred in a single sendfile() call. Without the limit, one fast connection may seize the worker process entirely.
    # read_ahead  0;  # read_ahead size; Default: read_ahead 0; Context: http, server, location -- Sets the amount of pre-reading for the kernel when working with file.
    # tcp_nopush  on;  # tcp_nopush on | off; Default: tcp_nopush off; Context: http, server, location -- Enables or disables the use of the TCP_NOPUSH socket option on FreeBSD or the TCP_CORK socket option on Linux.
    # tcp_nodelay  on;  # tcp_nodelay on | off; Default: tcp_nodelay on; Context: http, server, location -- Enables or disables the use of the TCP_NODELAY option.
    # postpone_output  1460;  # postpone_output size; Default: postpone_output 1460; Context: http, server, location -- If possible, the transmission of client data will be postponed until nginx has at least size bytes of data to send. The zero value disables postponing data transmission.
    # send_lowat  0;  # send_lowat size; Default: send_lowat 0; Context: http, server, location -- If the directive is set to a non-zero value, nginx will try to minimize the number of send operations on client sockets by using either NOTE_LOWAT flag of the kqueue method or the SO_SNDLOWAT socket option.

    # etag  on;  # etag on | off; Default: etag on; Context: http, server, location -- Enables or disables automatic generation of the “ETag” response header field for static resources.
    # if_modified_since  exact;  # if_modified_since off | exact | before; Default: if_modified_since exact; Context: http, server, location -- Specifies how to compare modification time of a response with the time in the “If-Modified-Since” request header field.
    # max_ranges;  # max_ranges number; Default: --; Context: http, server, location -- Limits the maximum allowed number of ranges in byte-range requests. Requests that exceed the limit are processed as if there were no byte ranges specified.
    # server_tokens  on;  # server_tokens on | off | build | string; Default: server_tokens on; Context: http, server, location -- Enables or disables emitting nginx version on error pages and in the “Server” response header field.

    # merge_slashes  on;  # merge_slashes on | off; Default: merge_slashes on; Context: http, server -- Enables or disables compression of two or more adjacent slashes in a URI into a single slash.
    # chunked_transfer_encoding  on;  # chunked_transfer_encoding on | off; Default: chunked_transfer_encoding on; Context: http, server, location -- Allows disabling chunked transfer encoding in HTTP/1.1. It may come in handy when using a software failing to support chunked encoding despite the standard’s requirement.
    # msie_padding  on;  # msie_padding on | off; Default: msie_padding on; Context: http, server, location -- Enables or disables adding comments to responses for MSIE clients with status greater than 400 to increase the response size to 512 bytes.
    # msie_refresh  off;  # msie_refresh on | off; Default: msie_refresh off; Context: http, server, location -- Enables or disables issuing refreshes instead of redirects for MSIE clients.

    # error_page;  # error_page code ... [=[response]] uri; Default: --; Context: http, server, location, if in location -- Defines the URI that will be shown for the specified errors.
    # recursive_error_pages  off;  # recursive_error_pages on | off; Default: recursive_error_pages off; Context: http, server, location -- Enables or disables doing several redirects using the error_page directive.
    # log_not_found  on;  # log_not_found on | off; Default: log_not_found on; Context: http, server, location -- Enables or disables logging of errors about not found files into error_log.
    # log_subrequest  off;  # log_subrequest on | off; Default: log_subrequest off; Context: http, server, location -- Enables or disables logging of subrequests into access_log.

    #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
    #                  '$status $body_bytes_sent "$http_referer" '
    #                  '"$http_user_agent" "$http_x_forwarded_for"';

    # use default log format: combined
    access_log  /var/log/nginx/access.log;

    server {
        # listen  80;  # Default: listen *:80 | *:8000; Context: server -- Sets the address and port for IP, or the path for a UNIX-domain socket on which the server will accept requests.
        # server_name  "";  # server_name name ...; Default: server_name ""; Context: server -- Sets names of a virtual server
        # try_files;  # try_files file ... uri; | try_files file ... =code; Default: --; Context: server, location -- Checks the existence of files in the specified order and uses the first found file for request processing; the processing is performed in the current context.
        listen  80;
        server_name  reading.yiyi123.cn;

        #charset koi8-r;

        access_log  /var/log/nginx/yiyireading.access.log;

        root  /srv/www/yiyireading/public;
        index index.html index.php;

        location / {
            # alias;  # alias path; Default: --; Context: location -- Defines a replacement for the specified location.
            # internal;  # internal; Default: --; Context: location -- Specifies that a given location can only be used for internal requests.
            # limit_except;  # limit_except method ... { ... } Default: --; Context: location -- Limits allowed HTTP methods inside a location.
            fastcgi_pass   127.0.0.1:9000;
            fastcgi_index  index.php;
            fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
            include        fastcgi_params;
        }
    }

}
