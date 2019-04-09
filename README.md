# rake-record

A sample Rake-only Active Record application.

## Setup

    bundle install
    bundle exec rake db:setup

    # list tasks with
    bundle exec rake -T

## Use

**List widgets**

    bundle exec rake widgets:query

**Fetch single widget**

    bundle exec rake widgets:fetch[1]

**Create widget**

    bundle exec rake widgets:create[Foo]

**Update widget**

    bundle exec rake widgets:update[1,Bar]
