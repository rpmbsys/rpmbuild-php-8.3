ARG rocky=10.0.20250606
FROM aursu/rpmbuild:${rocky}-build

USER root

COPY system/etc/yum.repos.d/bintray-custom-rocky.repo /etc/yum.repos.d/bintray-custom.repo

RUN dnf -y --enablerepo=bintray-custom --enablerepo=bintray-phpcustom install \
        php-cli \
        php-common \
        php-devel \
        php-process \
        php-xml \
    && dnf clean all && rm -rf /var/cache/dnf /var/lib/rpm/__db*
