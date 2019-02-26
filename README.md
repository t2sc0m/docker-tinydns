# adite/tinydns
---
## TinyDNS + DNSCache
![tescom](https://en.gravatar.com/userimage/96759029/aa4308f795041de37cc2fedf0d1071ca?size=128)

## Just simple TinyDNS & DNScache

## Volume
```shell
/etc/tinydns
/etc/dnscache
```

## Port
```shell
53/UDP : TinyDNS
53/TCP : DNSCache
```

## Usage

First, you need to create a TinyDNS data file on your host.
For example,
```shell
cat > {YOUR_TINYDNS_DATA_DIR}/data << EOF
.testdomain.com:10.0.0.1:ns.testdomain.com:3600
EOF
```

And run Container
```shell
docker run -dit -p 53:53/udp -p 53:53/tcp -v {YOUR_TINYDNS_DATA_FILE}:/etc/tinydns/root/data adite/tinydns
```

Then test DNS
```shell
$ dig testdomain.com soa @127.0.0.1 +short
ns.testdomain.com. hostmaster.testdomain.com. 1405869680 16384 2048 1048576 2560

$ dig ns.testdomain.com @127.0.0.1 +short
10.0.0.1
```
