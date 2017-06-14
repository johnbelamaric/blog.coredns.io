+++
date = "2017-06-14T22:52:11Z"
slug = "CoreDNS-008 Release Notes"
tags = ["Release", "008", "Notes"]
title = "CoreDNS-008 Release"
author = "john"
+++

CoreDNS-008 has been [released](https://github.com/coredns/coredns/releases/tag/v008)!

CoreDNS is a DNS server that chains middleware, where each middleware implements a DNS feature.

Release v008 has a lot of content, with new middleware and major features added to existing middleware.

Please note there is an *incompatible* change to the `log` directive - it now only logs to `stdout` and so
only allows `stdout` as the file name (which of course may be omitted).

# Core

* `-log` flag was changed into a boolean as all logging will be written to standard output.

# Middleware

## New

* *hosts* allows CoreDNS to read a `/etc/hosts` styled file and generate responses from that.
* *debug* can disable the `panic/recover` that is enabled by default. Mostly useful for testing/non-prod use cases to generate stack traces.

## Updates

* *chaos* now returns the correct `version.bind` `TXT` record.
* *kubernetes*
   * Now returns a proper NS record for the cluster domain
   * Supports `ExternalName` services, which was an oversight in the 1.0.0 version of the [Kubernetes dns spec](https://github.com/kubernetes/dns/blob/master/docs/specification.md)
   * Now supports federation records
   * Has had some other bug fixes.
* *file*
   * Now supports DNAME [RFC 6672](https://tools.ietf.org/html/rfc6672)
   * Refuse to load a zone without a SOA record.
* *file, auto* don't reload a zone when the SOA's serial hasn't changed.
* *secondary* now behaves properly if queried before the zone has been transferred
* *log, errors* output everything to *stdout* and let `journald` or `docker` (or whatever) that care of further handling. This is backwards **incompatible** change wrt to the Corefile: `log query.log` will return an error.
* *cache* got a new cache implementation to be more scalable and  a new `prefetch` option for fetching records before the TTL expires.
* *proxy* does not use `singleinflight` anymore, removing a potential bottleneck on the single mutex in that implementation; it now forwards *all* queries it get to the upstream nameserver.

