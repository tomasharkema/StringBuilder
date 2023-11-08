# FROM swift:5.9.0 AS package
# FROM swift:5.9.0 AS package
FROM swiftlang/swift:nightly-jammy AS base

FROM base AS package

WORKDIR /root

COPY Package.* .

ENV SWIFT_FORMAT_SKIP=true
ENV SWIFT_LINT_SKIP=true
ENV SWIFT_BUILD_DEPS=true

RUN --mount=type=cache,target=/tmp/build swift package resolve \
    --only-use-versions-from-resolved-file \
    --scratch-path /tmp/build && \
    cp -r /tmp/build /root/.build

FROM package AS source

COPY Sources Sources
COPY Tests Tests

RUN swift --version

FROM source AS source-dependencies

RUN swift build \
    --target _BuildDependencies

FROM source-dependencies AS source-debug
RUN swift build \
    --target TestRunner

FROM  source-dependencies AS source-test-build
RUN swift build --build-tests

FROM source-test-build AS source-test
RUN swift test --enable-code-coverage

FROM source-test AS source-release
RUN swift build -c release

FROM source-debug AS docs

COPY docs.sh .

RUN sh docs.sh

# FROM swift:5.9.0-slim
# WORKDIR /rootFROM nightly-5.9-jammy
FROM base

COPY --from=source-test /root/.build/debug /root/.build/debug
COPY --from=source-release /root/.build/release /root/.build/release
COPY --from=docs /root/docs /root/docs
