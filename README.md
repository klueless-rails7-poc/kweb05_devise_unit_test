# README

```bash
# source: https://www.youtube.com/watch?v=PtGjHGdJQrQ

rm -rf kweb05-devise-unit-test \
  && rails new kweb05-devise-unit-test \
  --skip-action-mailer \
  --skip-action-mailbox \
  --skip-action-text \
  --skip-active-storage \
  --skip-action-cable \
  --template ~/dev/kgems/k_templates/templates/ruby/rails_app/r7_hotwire.rb \
  && c kweb05-devise-unit-test/.

rg scaffold post title body:text user:references
``

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
