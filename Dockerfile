FROM rustlang/rust as builder
WORKDIR /app
COPY . .
RUN cargo build --release


FROM alpine:latest as runtime
LABEL authors="GitDataAI Team"
RUN apk add --no-cache ca-certificates tzdata openssl git
COPY --from=builder /app/target/release/jzflow /app/jzflow
WORKDIR /app
ENTRYPOINT ["/app/jzflow"]