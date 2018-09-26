function FindProxyForURL(url, host) {
    var direct = 'DIRECT;';
    var socks = 'SOCKS5 localhost:9876; SOCKS localhost:9876; DIRECT;';
    var domains = {
        "google.com": 1,
        "youtube.com": 1
    };

    // console.log(url);
    // console.log(host);
    var arr = host.split('.');
    if (arr.length > 2) {
        var suffix = arr[arr.length - 1];
        var i;
        for (i = arr.length - 2; i >= 0; i--) {
            suffix = arr[i] + '.' + suffix;
            if (domains[suffix]) {
                return socks;
            }
        }
    } else {
        if (domains[host]) {
            return socks;
        }
    }

    return direct;
}