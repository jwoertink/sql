# SQL

This is intended to be a very low level SQL builder. It should be fairly agnostic to the engine being used.
It's not inteded to run the SQL, but just turn Crystal code in to a giant SQL string for use under the hood
of an ORM, or just general type-safety.

⚠️ **this is mainly experimental and the API may change** ⚠️

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     sql:
       github: jwoertink/sql
   ```

2. Run `shards install`

## Usage

```crystal
require "sql"

# NOTE: This is all experimental playground and this may change
builder = SQL.builder

select_statement = SQL_Select.new
select_statement.write("name")

from_statement = SQL_From.new
from_statement.write("people")

builder.add(select_statement)
builder.add(from_statement)
builder.build

puts builder.to_s #=> SELECT name FROM people
```

## Development

* Write spec
* `crystal tool format spec/ src/`
* `./bin/ameba`
* Repeat

## Contributing

1. Fork it (<https://github.com/jwoertink/sql/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Jeremy Woertink](https://github.com/jwoertink) - creator and maintainer
