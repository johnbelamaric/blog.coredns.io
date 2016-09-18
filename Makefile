all:
	hugo -d /opt/www/blog.coredns.io

.PHONY:
clean:
	rm -rf /opt/www/blog.coredns.io/*

.PHONY:
test:
	hugo server
