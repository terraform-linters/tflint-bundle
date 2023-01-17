FROM --platform=$BUILDPLATFORM alpine:3.17.0 as builder

ARG TARGETOS TARGETARCH

ARG TFLINT_VERSION=0.44.1
ARG AWS_VERSION=0.21.1
ARG AZURERM_VERSION=0.20.0
ARG GOOGLE_VERSION=0.22.1

RUN wget -O /tmp/tflint.zip https://github.com/terraform-linters/tflint/releases/download/v"${TFLINT_VERSION}"/tflint_"${TARGETOS}"_"${TARGETARCH}".zip \
  && unzip /tmp/tflint.zip -d /usr/local/bin \
  && rm /tmp/tflint.zip

RUN mkdir -p ~/.tflint.d/plugins

RUN wget -O /tmp/tflint-ruleset-aws.zip https://github.com/terraform-linters/tflint-ruleset-aws/releases/download/v"${AWS_VERSION}"/tflint-ruleset-aws_"${TARGETOS}"_"${TARGETARCH}".zip \
  && unzip /tmp/tflint-ruleset-aws.zip -d ~/.tflint.d/plugins \
  && rm /tmp/tflint-ruleset-aws.zip

RUN wget -O /tmp/tflint-ruleset-azurerm.zip https://github.com/terraform-linters/tflint-ruleset-azurerm/releases/download/v"${AZURERM_VERSION}"/tflint-ruleset-azurerm_"${TARGETOS}"_"${TARGETARCH}".zip \
  && unzip /tmp/tflint-ruleset-azurerm.zip -d ~/.tflint.d/plugins \
  && rm /tmp/tflint-ruleset-azurerm.zip

RUN wget -O /tmp/tflint-ruleset-google.zip https://github.com/terraform-linters/tflint-ruleset-google/releases/download/v"${GOOGLE_VERSION}"/tflint-ruleset-google_"${TARGETOS}"_"${TARGETARCH}".zip \
  && unzip /tmp/tflint-ruleset-google.zip -d ~/.tflint.d/plugins \
  && rm /tmp/tflint-ruleset-google.zip

FROM alpine:3.17.0

LABEL maintainer=terraform-linters

ARG USER=tflint
ARG USER_ID=10001
ARG GROUP=tflint
ARG GROUP_ID=10001

RUN addgroup -g ${GROUP_ID} ${GROUP} && \
    adduser -h /home/${USER} -u ${USER_ID} -G ${GROUP} -D ${USER}

RUN apk add --no-cache ca-certificates && update-ca-certificates

COPY --from=builder /usr/local/bin/tflint /usr/local/bin
COPY --from=builder --chown=${USER}:${GROUP} /root/.tflint.d /home/${USER}/.tflint.d

USER ${USER}
WORKDIR /data

ENTRYPOINT ["tflint"]
