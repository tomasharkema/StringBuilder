FROM swift:5.9.1 AS package

WORKDIR /root

ENV SWIFT_FORMAT_SKIP=true
ENV SWIFT_LINT_SKIP=true

COPY Package.* .
RUN swift package resolve

FROM package AS source

COPY Sources Sources
COPY Tests Tests

FROM source AS source-debug
RUN swift build

FROM source-debug AS source-test
RUN swift test

FROM source AS source-release
RUN swift build -c release

FROM source-test AS docs

COPY docs.sh .

RUN sh docs.sh

FROM swift:5.9.1
# COPY --from=source-debug /root/.build/debug /root/.build/debug
COPY --from=source-release /root/.build/release /root/.build/release
COPY --from=docs /root/docs /root/docs
