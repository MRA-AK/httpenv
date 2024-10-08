# Stage 1: Build
FROM golang:alpine AS builder
COPY httpenv.go /go
RUN go build httpenv.go

# Stage 2: Test (you can add Go unit tests or any other testing logic here)
FROM builder AS test

# Stage 3: Final image
FROM alpine
RUN addgroup -g 1000 httpenv \
    && adduser -u 1000 -G httpenv -D httpenv
COPY --from=builder --chown=httpenv:httpenv /go/httpenv /httpenv
EXPOSE 8888
# we're not changing user in this example, but you could:
# USER httpenv
CMD ["/httpenv"]