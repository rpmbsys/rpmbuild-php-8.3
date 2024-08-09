ARG os=8.10.20240528
FROM aursu/php83build:${os}-base

COPY SOURCES ${BUILD_TOPDIR}/SOURCES
COPY SPECS ${BUILD_TOPDIR}/SPECS

RUN chown -R $BUILD_USER ${BUILD_TOPDIR}/{SOURCES,SPECS}

USER $BUILD_USER
ENTRYPOINT ["/usr/bin/rpmbuild", "php83.spec", "--with", "cgi", "--with", "fpm"]
CMD ["-ba"]
