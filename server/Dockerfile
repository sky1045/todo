FROM golang:1.18 as build-env

WORKDIR /go/src/todo
ADD . /go/src/todo

RUN go get -d -v ./...

RUN go build -o /go/bin/todo

FROM gcr.io/distroless/base
COPY --from=build-env /go/bin/todo /
COPY --from=build-env /go/src/todo/index.html /
CMD ["/todo"]
