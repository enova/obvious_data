Obvious Data
============

[![Gem Version](https://badge.fury.io/rb/obvious_data.svg)](https://rubygems.org/gems/obvious_data)
[![Build Status](https://travis-ci.org/enova/obvious_data.svg?branch=master)](https://travis-ci.org/enova/obvious_data)
[![Coverage Status](https://coveralls.io/repos/github/enova/obvious_data/badge.svg?branch=master)](https://coveralls.io/github/enova/obvious_data?branch=master)
[![Dependency Status](https://gemnasium.com/enova/obvious_data.svg)](https://gemnasium.com/enova/obvious_data)

Rails gem to treat DB functions, triggers, etc more like code, and make them more discoverable

Premise
=======
Database functions, triggers, and views can be very powerful when used in the right circumstances, but they lack the discoverability and versioning of source code. Short of logging into your databases, it is difficult to tell what versions of functions and triggers are active, nevermind getting a good picture of what are all the custom functions and triggers in place in your application.

Obvious Data improves this by creating directories for you to place these constructs, treating them more like code and instantly making them greppable, and adding helper methods where you can easily use these files from your migrations.

Usage
=====

### Creating directories
```
$ bin/rails generate obvious_data_directories
```

This will generate empty `db/functions`, `db/views`, and `db/triggers` directories for you to use.

### Adding functions
Say you want to add a function called `one()`. You should create a file called `one.sql` in `db/functions/` with the SQL that's needed to add that function. Thus:

_db/functions/one.sql_:

```
CREATE OR REPLACE FUNCTION one() RETURNS integer AS $$
  SELECT 1 AS result;
$$ LANGUAGE SQL;
```

Then, from a migration you can add this function like:

*db/migrate/20140724185749_create_one_function.rb*

```ruby
class CreateDummyTable < ActiveRecord::Migration
  def up
    execute_function_file 'one'
  end

  def down
    drop_function 'one()'
  end
end
```

Run your migration and your function should be operational!

### Changing functions
Say it is suddenly decreed that the numeric representation of "one" is now 99. To keep the active version of your function discoverable, you are expected to change the same function file you created in the above section in place, and updating it through a new migration. So:

*db/functions/one.sql*:

```
CREATE OR REPLACE FUNCTION one() RETURNS integer AS $$
  SELECT 99 AS result;
$$ LANGUAGE SQL;
```

*db/migrate/20140724185750_one_function_to_99.rb*

```ruby
class CreateDummyTable < ActiveRecord::Migration
  def up
    execute_function_file 'one'
  end

  def down
    # Unfortunately there's currently no easy way to revert this situation
  end
end
```

### Dropping functions
What do you do when you no longer want to use a class from your source code? You delete it! Which is the same thing we'll do here. In the migration, make sure to use the full function signature instead of just the function name.

*db/functions/one.sql: *deleted**

*db/migrate/20140724185751_drop_one_function.rb:*

```ruby
class CreateDummyTable < ActiveRecord::Migration
  def up
    drop_function 'one()'
  end

  def down
    # Unfortunately there's currently no easy way to revert this situation
  end
end
```

### Adding/changing/dropping views and triggers
Practically the same as adding and changing functions. The available migration helpers are:

- `execute_view_file(view_name)`
- `drop_view(view_name)`
- `execute_trigger_file(trigger_name)`
- `drop_trigger(trigger_name, table_trigger_is_on)`

Supported Databases etc
=======================

- Currently the only database supported is PostgreSQL, but no reason that other DBs can't also be supported
- Rails version 3.2.x through 4.2.x
- Ruby versions 1.9.3, 2.1.x, and rubinius 2.2+

Contributing
============
Make sure you run the tests before and after making changes. Here's how:

- Ensure PostgreSQL is installed
- Run `bundle install`
- Run `bundle exec rake app:db:create`
- Run `bundle exec rake app:db:setup app:db:migrate app:db:test:prepare`
- Run `bundle exec rspec`
