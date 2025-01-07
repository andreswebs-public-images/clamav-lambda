FROM public.ecr.aws/lambda/provided:al2 AS clamav

ARG BUILD_DIR="/var/local/build"
ARG LAYER_DIR="/opt"

RUN \
    mkdir -p \
        "${BUILD_DIR}" \
        "${LAYER_DIR}/bin" \
        "${LAYER_DIR}/lib"

RUN \
    cd "${BUILD_DIR}" && \
    yum install -y cpio yum-utils && \
    yum install -y https://archives.fedoraproject.org/pub/archive/epel/7/x86_64/Packages/e/epel-release-7-14.noarch.rpm && \
    yum-config-manager --enable epel && \
    rpm --import /etc/pki/rpm-gpg/*GPG* && \
    yumdownloader -x \*i686 --archlist=x86_64 \
        bzip2-libs \
        clamav \
        clamav-lib \
        clamav-update \
        gnutls \
        json-c \
        libprelude \
        libtasn1 \
        libtool-ltdl \
        libxml2 \
        nettle \
        pcre2 \
        xz-libs && \
    rpm2cpio bzip2-libs*.rpm | cpio -idmv && \
    rpm2cpio clamav-0*.rpm | cpio -idmv && \
    rpm2cpio clamav-lib*.rpm | cpio -idmv && \
    rpm2cpio clamav-update*.rpm | cpio -idmv && \
    rpm2cpio gnutls*.rpm | cpio -idmv && \
    rpm2cpio json-c*.rpm | cpio -idmv && \
    rpm2cpio libprelude*.rpm | cpio -idmv && \
    rpm2cpio libtasn1*.rpm | cpio -idmv && \
    rpm2cpio libtool-ltdl*.rpm | cpio -idmv && \
    rpm2cpio libxml2*.rpm | cpio -idmv && \
    rpm2cpio nettle*.rpm | cpio -idmv && \
    rpm2cpio pcre2*.rpm | cpio -idmv && \
    rpm2cpio xz-libs*.rpm | cpio -idmv && \
    cp \
        "${BUILD_DIR}"/usr/bin/* \
        "${LAYER_DIR}"/bin && \
    cp \
        "${BUILD_DIR}"/usr/lib64/* \
        "${LAYER_DIR}"/lib && \
    rm -rf "${BUILD_DIR}"

