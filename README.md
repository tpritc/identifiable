# Identifiable

Identifiable makes is really quick and easy way to add random, customizable, public-facing IDs to your models. These are great for URLs and reports, where you might not want to share the record's `id` attribute.

## Why do I need public-facing IDs?

If you're asking this question, you probably use your record's `id` attribute as its identifier in its URL. This can be an issue for two main reasons:

1. If you've got a low number of records (if you're just getting started, for instance) it might look unprofessional to have a low ID number. Simply put, `https://example.app/orders/14` doesn't look as good as `https://example.app/orders/87133275`. Even if you've only got 14 orders so far, you might want to _look_ like you've got more. Fake it 'til you make it!
2. If you're exposing things to the open web, using auto-incrementing IDs means someone hoping to scrape your app can just increment the ID parameter in the URL and get everything. With randomly generated public IDs, scrapers can't just add 1 to each ID to find valid pages.

Identifiable makes it really simple to generate and use random public-facing IDs in your Rails applications.

```ruby
# Before:
orders_url(id: @order.id) # → https://example.app/orders/14

# After:
orders_url(id: @order.public_id) # → https://example.app/orders/87133275
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'identifiable'
```

Then run `bundle install` and you'll be set.

## Usage

Adding Identifiable to your Rails models couldn't be simpler. The easiest, most default way to add public IDs is to just add `identifiable` to your model. This'll default to 8-character long numeric public IDs (like `23843274` or `98237268`, for instance) on the `public_id` column of your model. These public IDs will be automatically set when you create your records.

```ruby
class Order < ApplicationRecord
  identifiable
end
```

Identifiable doesn't create the columns for your model, so you will need to add those yourself when you create your models (or add the columns when adding Identifiable to an existing model). These columns will also need an index on them. To add a `public_id` string column with an index to your `Order` model, you can run in your command line:

```bash
bundle exec rails generate migration add_public_id_to_orders public_id:index
bundle exec rails db:migrate
```

If you don't have the public id column set up, Identifiable will raise an error.

### Finding by your model's public ID

If you're used to using `Model.find(id)` in your controllers, no need to fret! Now you can replace it with `Model.find_by_public_id!(public_id)` and you'll get the same behavior, including raising `ActiveRecord::RecordNotFound` if the record doesn't exist. It's plug-and-play.

You can also use `Model.find_by_public_id(public_id)`, which is similar, but does not raise an error if the record doesn't exist, you'll just get `nil` instead.

Because your public ID is just a column in your database, you can also use all the standard Rails ways of accessing records, including `#where` and `#find_by`.

### Adding public IDs to existing records

Public IDs are assigned when saving a record if the public ID isn't already set, so to add public IDs to existing records, you just need to re-run a `#save` on each one, like so:

```ruby
Order.all.find_each do |order|
  order.save!
end
```

## Customization

While Identifiable strives to have useful defaults, you may want to customize your public IDs for your particular application, or even for particular models in your application.

### Different public ID styles

By default, Identifiable will generate numeric public IDs, with each character between 0 and 9, but it can also generate alphanumeric public IDs and UUID public ids. To chose your public ID style, simply pass it in as a parameter to `identifiable` on your model.

```ruby
class Order < ApplicationRecord
  # Valid options for style are :numeric (default), :alphanumeric, and :uuid
  identifiable style: :alphanumeric
end
```

Here's how each available style looks:

* `:numeric` produces public ids with numbers between 0 and 9 for each character, and looks like `23843274`.
* `:alphanumeric` produces public ids with uppercase letters (A-Z), lowercase letters (a-z), and numbers (0-9) for each character, and looks like `a3ZG8fkP`.
* `:uuid` produces public ids that match the [UUID specification in RFC 4122](https://tools.ietf.org/html/rfc4122), and look like `adea0700-94de-4075-bbf0-7853cffcca50`.

### Changing the public ID column

By default, Identifiable will assume your public ID column is `public_id`, but you can pick another column if you want. For instance, you might want to use `share_link_id` for a publicly shareable link. To do so, simply pass the column name as a symbol to `identifiable` on your model.

```ruby
class Order < ApplicationRecord
  # Defaults to `:public_id`. In this example, the column `share_link_id` must
  # exist in the `orders` table, otherwise Identifiable will raise an error.
  identifiable column: :share_link_id
end
```

### Changing the length of the public ID

Numeric and alphanumeric public IDs default to 8 characters long, but in your application you might want more (or less) than that. The `length` parameter of `identifiable` is used to set the length of these public IDs, and defaults to `8`.

```ruby
class Order < ApplicationRecord
  # This configuration will produce 16 character long alphanumeric public IDs.
  identifiable style: :alphanumeric, length: 16
end
```

The `length` parameter is ignored if you're using `style: :uuid`, because UUIDs already have a fixed length. The `length` parameter also needs be an Integer, and can't be less than `4` or greater than `128`. If any of these constraints are broken, Identifiable will raise an error letting you know.

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/tpritc/identifiable). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/tpritc/identifiable/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT). If you or your organization need a custom, commercial license for any reason, [send me an email](mailto:hi@tpritc.com) and I'll be happy to set something up for you.

## Code of Conduct

Everyone interacting in the Identifiable project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/tpritc/identifiable/blob/main/CODE_OF_CONDUCT.md).
