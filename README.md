========================
Docker thumbor
========================

Docker base image for thumbor.
Thumbor config managed with env vars.


Other configuration managed with envtpl (nginx, circusd).

Description
===========

Docker thumbor image 

* See parent image https://registry.hub.docker.com/u/apsl/circusbase
* circus to control processes. http://circus.readthedocs.org/
* envtpl to setup config files on start time, based on environ vars. https://github.com/andreasjansson/envtpl

Ports
=====

* 80: nginx django app, serving static
* 8000: thumbor port directly, without nginx cache

Env vars:
=========


