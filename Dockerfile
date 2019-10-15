FROM ruby:2.6.5
COPY ./Gemfile /apps/Gemfile
COPY ./Gemfile.lock /apps/Gemfile.lock
WORKDIR /apps
RUN bundle install
EXPOSE 3000
CMD ["bash"]
