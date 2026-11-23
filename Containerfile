FROM docker.io/ubuntu@sha256:29ac5e68db830ab61b7d77c1ffdb78c73f0631de88a5d77bf4399868f64f38dd

WORKDIR /tmp

ARG VCS_VERSION=edge
ARG VSC_REVISION=unknown

ENV VCS_VERSION=${VCS_VERSION}
ENV VSC_REVISION=${VSC_REVISION}

# https://snyk.io/de/blog/how-and-when-to-use-docker-labels-oci-container-annotations/
LABEL org.opencontainers.image.title="linter"
LABEL org.opencontainers.image.description="A container image composed of common linters"
LABEL org.opencontainers.image.source="https://github.com/georglauterbach/linter"
LABEL org.opencontainers.image.revision="${VSC_REVISION}"
LABEL org.opencontainers.image.base.digest="6a06111c3b0a8600feadb270aec771dc239bf407b25625f93f44ab00e11f4d3c"
LABEL org.opencontainers.image.base.name="docker.io/ubuntu"
LABEL org.opencontainers.image.version="${VCS_VERSION}"

ENV ACTIONLINT_VERSION=1.7.12
ENV EDITORCONFIG_CHECKER_VERSION=4.0.2
ENV HADOLINT_VERSION=2.15.1
ENV SHELLCHECK_VERSION=0.11.0
ENV YAMLLINT_VERSION=1.38.0-1
ENV ZIZMOR_VERSION=1.33.1

# hadolint ignore=DL3008
RUN apt-get -qq update \
    && apt-get -qq -o=Dpkg::Use-Pty=0 install --no-install-recommends ca-certificates wget \
    && wget --quiet -O- \
        "https://github.com/rhysd/actionlint/releases/download/v${ACTIONLINT_VERSION}/actionlint_${ACTIONLINT_VERSION}_linux_$(dpkg --print-architecture).tar.gz" \
        | tar zx -C /usr/local/bin actionlint \
    && wget --quiet -O- \
        "https://github.com/editorconfig-checker/editorconfig-checker/releases/download/v${EDITORCONFIG_CHECKER_VERSION}/editorconfig-checker-linux-$(dpkg --print-architecture).tar.gz" \
        | tar zx -C /usr/local/bin editorconfig-checker \
    && wget --quiet -O /usr/local/bin/hadolint \
        "https://github.com/hadolint/hadolint/releases/download/v${HADOLINT_VERSION}/hadolint-linux-$(uname -m)" \
    && wget --quiet -O- \
        "https://github.com/koalaman/shellcheck/releases/download/v${SHELLCHECK_VERSION}/shellcheck-v${SHELLCHECK_VERSION}.linux.$(uname -m).tar.gz" \
        | tar zx --strip-components 1 -C /usr/local/bin "shellcheck-v${SHELLCHECK_VERSION}/shellcheck" \
    && apt-get -qq -o=Dpkg::Use-Pty=0 install --no-install-recommends yamllint=${YAMLLINT_VERSION} \
    && wget --quiet -O- \
        "https://github.com/zizmorcore/zizmor/releases/download/v${ZIZMOR_VERSION}/zizmor-$(uname -m)-unknown-linux-gnu.tar.gz" \
        | tar zx -C /usr/local/bin zizmor \
    && chmod +x /usr/local/bin/* \
    && apt-get -qq autoremove --purge ca-certificates wget \
    && rm -rf /var/cache/apt/archives /var/lib/apt/lists

COPY libbash       /etc/linters/libbash
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY configuration /etc/linters/configuration

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
