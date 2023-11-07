#!/bin/sh

swift package --allow-writing-to-directory docs \
	generate-documentation --target StringBuilder \
	--transform-for-static-hosting \
	--hosting-base-path swift-tracing \
	--output-path docs \
	--include-extended-types

# swift package --allow-writing-to-directory docs \
#     generate-documentation --target SwiftTracing \
#     --transform-for-static-hosting \
#     --hosting-base-path swift-tracing \
#     --output-path docs \
#     --include-extended-types

# swift package --allow-writing-to-directory docs \
#     generate-documentation --target SwiftTaskToolbox \
#     --transform-for-static-hosting \
#     --hosting-base-path swift-tracing \
#     --output-path docs

# swift package --allow-writing-to-directory docs \
#     generate-documentation --target SwiftThreading \
#     --transform-for-static-hosting \
#     --hosting-base-path swift-tracing \
#     --output-path docs
