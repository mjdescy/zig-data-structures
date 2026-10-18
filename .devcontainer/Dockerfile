FROM debian:13-slim

ARG TARGETARCH

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl git xz-utils \
    && rm -rf /var/lib/apt/lists/*

RUN set -eux; \
    case "${TARGETARCH}" in \
        amd64) \
            zig_arch="x86_64"; \
            zig_sha256="1cbe9df9f27e6b78d14ccbca43b6703a404ef79ef1c463de901d7f088d4e2026"; \
            ;; \
        arm64) \
            zig_arch="aarch64"; \
            zig_sha256="9e8d11661d4ae3bd57702a3832781e23ad151dde5798e16a5ccd503f65234ff8"; \
            ;; \
        *) \
            echo "Unsupported target architecture: ${TARGETARCH}" >&2; \
            exit 1; \
            ;; \
    esac; \
    curl -fsSL "https://ziglang.org/download/0.17.0/zig-${zig_arch}-linux-0.17.0.tar.xz" -o /tmp/zig.tar.xz; \
    echo "${zig_sha256}  /tmp/zig.tar.xz" | sha256sum --check --status; \
    mkdir -p /opt/zig; \
    tar -xJf /tmp/zig.tar.xz --strip-components=1 -C /opt/zig; \
    rm /tmp/zig.tar.xz

ENV PATH="/opt/zig:${PATH}"

RUN git clone --filter=blob:none https://github.com/zigtools/zls.git /tmp/zls \
    && cd /tmp/zls \
    && git checkout --detach 4e83599939e9723a8cf7961bb77214549c885116 \
    && zig build -Doptimize=ReleaseSafe \
    && install -m 0755 zig-out/bin/zls /usr/local/bin/zls \
    && rm -rf /tmp/zls
