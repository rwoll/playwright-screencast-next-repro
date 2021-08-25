FROM ubuntu:focal
RUN apt-get update && apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs
WORKDIR /opt/test
ARG VERSION
COPY ./${VERSION}/package.json .
COPY ./${VERSION}/package-lock.json .
# NB: Lots of layers and dupe installs; not optimized :P Don't judge!
RUN npm ci
RUN DEBIAN_FRONTEND=noninteractive npx playwright install-deps chrome
RUN DEBIAN_FRONTEND=noninteractive npx playwright install chrome --with-deps || DEBIAN_FRONTEND=noninteractive npx playwright install chrome
COPY ./playwright.config.ts .
COPY ./screencast.spec.ts .
CMD ["xvfb-run", "--", "npx", "playwright", "test", "--repeat-each", "5"]
