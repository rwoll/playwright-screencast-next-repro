FROM ubuntu:focal
RUN apt-get update && apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs

ARG VERSION

# NB: Lots of layers and dupe installs; not optimized :P Don't judge!
WORKDIR /tmp/pw-chrome
RUN npm init -y && npm i playwright@1.$VERSION
RUN DEBIAN_FRONTEND=noninteractive npx playwright install-deps
RUN DEBIAN_FRONTEND=noninteractive npx playwright install chrome --with-deps || DEBIAN_FRONTEND=noninteractive npx playwright install chrome
RUN rm -rf /tmp/pw-chrome

RUN useradd -m tester
USER tester
WORKDIR /opt/tester
COPY ./${VERSION}/package.json .
COPY ./${VERSION}/package-lock.json .
RUN npm ci
COPY ./playwright.config.ts .
COPY ./screencast.spec.ts .
CMD ["xvfb-run", "--", "npx", "playwright", "test"]
