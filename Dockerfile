FROM public.ecr.aws/lambda/provided:al2 AS clamav

ARG BUILD_DIR="/var/local/build"
ARG LAYER_DIR="/opt"

RUN \
  mkdir -p \
    "${LAYER_DIR}/bin" \
    "${LAYER_DIR}/lib"

RUN \
  mkdir -p "${BUILD_DIR}" && \
  cd "${BUILD_DIR}" && \
  yum install -y cpio yum-utils && \
  yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
  yum-config-manager --enable epel && \
  yumdownloader -x \*i686 --archlist=x86_64 \
    clamav \
    clamav-lib \
    clamav-update \
    json-c \
    pcre2 \
    libxml2 \
    bzip2-libs \
    libtool-ltdl \
    xz-libs && \
  rpm2cpio clamav-0*.rpm | cpio -idmv && \
  rpm2cpio clamav-lib*.rpm | cpio -idmv && \
  rpm2cpio clamav-update*.rpm | cpio -idmv && \
  rpm2cpio json-c*.rpm | cpio -idmv && \
  rpm2cpio pcre2*.rpm | cpio -idmv && \
  rpm2cpio libxml2*.rpm | cpio -idmv && \
  rpm2cpio bzip2-libs*.rpm | cpio -idmv && \
  rpm2cpio libtool-ltdl*.rpm | cpio -idmv && \
  rpm2cpio xz-libs*.rpm | cpio -idmv && \
  cp \
    "${BUILD_DIR}"/usr/bin/* \
    "${LAYER_DIR}"/bin && \
  cp \
    "${BUILD_DIR}"/usr/lib64/* \
    "${LAYER_DIR}"/lib && \
  rm -rf "${BUILD_DIR}"

