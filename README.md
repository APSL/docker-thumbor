========================
Docker thumbor and remotecv
========================

Docker image for thumbor, and separated one for remotecv, necessary for the lazy detection.
All parameters of the thumbor config can be set with env vars.
The thumbor docker expose two ports, the thumbor service and nginx cache. The nginx cache check if the file exists in the file_storage after to send the request to thumbor (automated failover).


Description
===========

Docker thumbor image

* All configuration via environment variables
* Opencv detectors
* Optimizer JPEG included
* Nginx cache to optimize the server of optimized images
* Separated remotecv docker image
* A lot of docker-compose examples with tipical uses cases
* See parent image https://registry.hub.docker.com/u/apsl/circusbase
* circus to control processes. http://circus.readthedocs.org/
* envtpl to setup config files on start time, based on environ vars. https://github.com/andreasjansson/envtpl

Ports
=====

* 80: nginx cache, check if the file exists in result_storage and serve, failover to thumbor auto
* 8000: thumbor port directly, without nginx cache

Docker-compose examples
=======================

Check the docker-compose examples:

* File storage with detection
* Lazy detection using redis
* Optimization
* AWS S3 storage

Env vars and default value:
=========
    THUMBOR_LOG_FORMAT='%(asctime)s %(name)s:%(levelname)s %(message)s'
    THUMBOR_LOG_DATE_FORMAT='%Y-%m-%d %H:%M:%S'
    MAX_WIDTH=0
    MAX_HEIGHT=0
    MIN_WIDTH=1
    MIN_HEIGHT=1
    ALLOWED_SOURCES=[]
    QUALITY=80
    WEBP_QUALITY=None
    AUTO_WEBP=False
    MAX_AGE=86400
    MAX_AGE_TEMP_IMAGE=0
    RESPECT_ORIENTATION=False
    IGNORE_SMART_ERRORS=False
    PRESERVE_EXIF_INFO=False
    ALLOW_ANIMATED_GIFS=True
    USE_GIFSICLE_ENGINE=False
    USE_BLACKLIST=False
    LOADER='thumbor.loaders.http_loader'
    STORAGE='thumbor.storages.file_storage'
    STORAGE_BUCKET=''
    AWS_ACCESS_KEY=''
    AWS_SECRET_KEY=''
    RESULT_STORAGE='thumbor.result_storages.file_storage'
    ENGINE='thumbor.engines.pil'
    SECURITY_KEY='MY_SECURE_KEY'
    ALLOW_UNSAFE_URL=True
    ALLOW_OLD_URLS=True
    FILE_LOADER_ROOT_PATH='/data/loader'
    HTTP_LOADER_CONNECT_TIMEOUT=5
    HTTP_LOADER_REQUEST_TIMEOUT=20
    HTTP_LOADER_FOLLOW_REDIRECTS=True
    HTTP_LOADER_MAX_REDIRECTS=5
    HTTP_LOADER_FORWARD_USER_AGENT=False
    HTTP_LOADER_DEFAULT_USER_AGENT='Thumbor/5.0.3'
    HTTP_LOADER_PROXY_HOST=None
    HTTP_LOADER_PROXY_PORT=None
    HTTP_LOADER_PROXY_USERNAME=None
    HTTP_LOADER_PROXY_PASSWORD=None
    STORAGE_EXPIRATION_SECONDS=2592000
    STORES_CRYPTO_KEY_FOR_EACH_IMAGE=False
    FILE_STORAGE_ROOT_PATH='/data/storage'
    UPLOAD_MAX_SIZE=0
    UPLOAD_ENABLED=False
    UPLOAD_PHOTO_STORAGE='thumbor.storages.file_storage'
    UPLOAD_DELETE_ALLOWED=False
    UPLOAD_PUT_ALLOWED=False
    UPLOAD_DEFAULT_FILENAME='image'
    MONGO_STORAGE_SERVER_HOST='mongo'
    MONGO_STORAGE_SERVER_PORT='27017'
    MONGO_STORAGE_SERVER_DB='thumbor'
    MONGO_STORAGE_SERVER_COLLECTION='images'
    REDIS_STORAGE_SERVER_HOST='redis'
    REDIS_STORAGE_SERVER_PORT='6379'
    REDIS_STORAGE_SERVER_DB=0
    REDIS_STORAGE_SERVER_PASSWORD=None
    MEMCACHE_STORAGE_SERVERS=['localhost:11211',]
    MIXED_STORAGE_FILE_STORAGE='thumbor.storages.no_storage'
    MIXED_STORAGE_CRYPTO_STORAGE='thumbor.storages.no_storage'
    MIXED_STORAGE_DETECTOR_STORAGE='thumbor.storages.no_storage'
    META_CALLBACK_NAME=None
    DETECTORS=[]
    FACE_DETECTOR_CASCADE_FILE='haarcascade_frontalface_alt.xml'
    OPTIMIZERS=[]
    JPEGTRAN_PATH='/usr/bin/jpegtran'
    PROGRESSIVE_JPEG=True
    FILTERS=['thumbor.filters.brightness', 'thumbor.filters.contrast', 'thumbor.filters.rgb', 'thumbor.filters.round_corner', 'thumbor.filters.quality', 'thumbor.filters.noise', 'thumbor.filters.watermark', 'thumbor.filters.equalize', 'thumbor.filters.fill', 'thumbor.filters.sharpen', 'thumbor.filters.strip_icc', 'thumbor.filters.frame', 'thumbor.filters.grayscale', 'thumbor.filters.rotate', 'thumbor.filters.format', 'thumbor.filters.max_bytes', 'thumbor.filters.convolution', 'thumbor.filters.blur', 'thumbor.filters.extract_focal', 'thumbor.filters.no_upscale']
    RESULT_STORAGE_EXPIRATION_SECONDS=0
    RESULT_STORAGE_FILE_STORAGE_ROOT_PATH='/data/result_storage'
    RESULT_STORAGE_STORES_UNSAFE=False
    REDIS_QUEUE_SERVER_HOST='redis'
    REDIS_QUEUE_SERVER_PORT='6379'
    REDIS_QUEUE_SERVER_DB='0'
    REDIS_QUEUE_SERVER_PASSWORD=None
    SQS_QUEUE_KEY_ID=None
    SQS_QUEUE_KEY_SECRET=None
    SQS_QUEUE_REGION='us-east-1'
    USE_CUSTOM_ERROR_HANDLING=False
    ERROR_HANDLER_MODULE='thumbor.error_handlers.sentry'
    ERROR_FILE_LOGGER=None
    ERROR_FILE_NAME_USE_CONTEXT='False'
    SENTRY_DSN_URL=''
