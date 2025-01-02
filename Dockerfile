FROM python:alpine AS build

RUN apk add --no-cache build-base libffi-dev cargo openssl-dev

RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install nomadnet --no-binary :all:

FROM python:alpine

ENV PATH="/opt/venv/bin:$PATH"
ENV PYTHONUNBUFFERED="yes"
COPY --from=build /opt/venv /opt/venv

VOLUME /root/.reticulum
VOLUME /root/.nomadnetwork

ENTRYPOINT ["nomadnet"]
CMD ["--daemon"]
