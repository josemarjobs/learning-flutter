FROM golang:alpine as build-end

ENV GO111MODULE=on

RUN apk update && apk add bash ca-certificates git gcc g++ libc-dev

RUN mkdir -p /chatserver/proto

WORKDIR /chatserver

COPY ./proto/service.pb.go /chatserver/proto
COPY ./main.go /chatserver

COPY go.mod .
COPY go.sum .

RUN go mod download

RUN go build -o chatserver .

CMD ./chatserver
