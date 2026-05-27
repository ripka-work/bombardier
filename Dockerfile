FROM golang as builder

WORKDIR /go/src/loader
COPY . .

RUN CGO_ENABLED=0 GOOD=linux go build 

FROM debian:bookworm
#gcr.io/google.com/cloudsdktool/google-cloud-cli:stable
RUN apt update
RUN apt install curl -y

COPY --from=builder /go/src/loader/bombardier /usr/bin/.

COPY bombard.sh /usr/bin/bombard.sh

CMD ["bombard.sh"]
