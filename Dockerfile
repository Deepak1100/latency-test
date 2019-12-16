FROM ruby:2.5.1
WORKDIR /app/
COPY Gemfile /app/
RUN bundle install
COPY . /app/
CMD ["ruby", "dynamodb-test.rb"]
