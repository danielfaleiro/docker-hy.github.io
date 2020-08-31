FROM jekyll/jekyll:3.8.3 as build-stage

WORKDIR /tmp

COPY Gemfile* ./

RUN bundle install

WORKDIR /usr/src/app

COPY . .

RUN chown -R jekyll . \
    && jekyll build \
    && rm -rf /var/lib/apt/lists/* 

FROM nginx:alpine

COPY --from=build-stage /usr/src/app/_site/ /usr/share/nginx/html
