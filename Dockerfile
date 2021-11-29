FROM alpine:3.15.0 as builder

ARG TFLINT_VERSION=0.33.1
ARG AWS_VERSION=0.8.0
ARG AZURERM_VERSION=0.13.2
ARG GOOGLE_VERSION=0.13.2

RUN wget -O /tmp/tflint.zip https://github.com/terraform-linters/tflint/releases/download/v"${TFLINT_VERSION}"/tflint_linux_amd64.zip \
  && unzip /tmp/tflint.zip -d /usr/local/bin \
  && rm /tmp/tflint.zip

RUN mkdir -p ~/.tflint.d/plugins

RUN wget -O /tmp/tflint-ruleset-aws.zip https://github.com/terraform-linters/tflint-ruleset-aws/releases/download/v"${AWS_VERSION}"/tflint-ruleset-aws_linux_amd64.zip \
  && unzip /tmp/tflint-ruleset-aws.zip -d ~/.tflint.d/plugins \
  && rm /tmp/tflint-ruleset-aws.zip

RUN wget -O /tmp/tflint-ruleset-azurerm.zip https://github.com/terraform-linters/tflint-ruleset-azurerm/releases/download/v"${AZURERM_VERSION}"/tflint-ruleset-azurerm_linux_amd64.zip \
  && unzip /tmp/tflint-ruleset-azurerm.zip -d ~/.tflint.d/plugins \
  && rm /tmp/tflint-ruleset-azurerm.zip

RUN wget -O /tmp/tflint-ruleset-google.zip https://github.com/terraform-linters/tflint-ruleset-google/releases/download/v"${GOOGLE_VERSION}"/tflint-ruleset-google_linux_amd64.zip \
  && unzip /tmp/tflint-ruleset-google.zip -d ~/.tflint.d/plugins \
  && rm /tmp/tflint-ruleset-google.zip

FROM alpine:3.15.0

LABEL maintainer=terraform-linters

RUN apk add --no-cache ca-certificates

COPY --from=builder /usr/local/bin/tflint /usr/local/bin
COPY --from=builder /root/.tflint.d /root/.tflint.d

ENTRYPOINT ["tflint"]
WORKDIR /data
