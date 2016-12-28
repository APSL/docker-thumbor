FROM apsl/thumbor
MAINTAINER Edu Herraiz <ghark@gmail.com>

RUN pip uninstall -y pillow; true;
ARG SIMD_LEVEL=sse4
RUN CC="cc -m$SIMD_LEVEL" pip install --no-cache-dir -U --force-reinstall pillow-simd

