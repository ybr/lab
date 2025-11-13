# docker build -t awscli -f awscli.dockerfile .
# docker run -it --rm -v ~/.aws/credentials:/root/.aws/credentials awscli
# Type: awscli configure

FROM alpine:3.20

RUN apk update && \
    apk add --no-cache aws-cli

ENTRYPOINT ["sh"]
