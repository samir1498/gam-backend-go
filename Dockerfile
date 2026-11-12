FROM golang:1.26-alpine AS builder
WORKDIR /app
RUN apk add --no-cache git make
RUN go install github.com/pressly/goose/v3/cmd/goose@v3.24.3
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o /app/bin/api ./cmd/api

FROM alpine:3.20
RUN apk add --no-cache ca-certificates
COPY --from=builder /app/bin/api /api
COPY --from=builder /go/bin/goose /usr/local/bin/goose
COPY migrations /migrations
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENV PORT=8080
EXPOSE 8080
ENTRYPOINT ["/docker-entrypoint.sh"]
