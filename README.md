# Rubocop::Chr

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/rubocop/chr`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rubocop-chr', require: false
```

And add the following code to your `.rubocop.yml` file:

```yaml
require:
  - rubocop-chr
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install rubocop-chr
```

## Usage

Now when you run `rubocop` it will include your custom cops.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Useful links

- [Rubocop Extensions](https://docs.rubocop.org/rubocop/extensions.html)
- [Rubocop Development](https://docs.rubocop.org/rubocop/development.html)
- [Rubocop::NodePattern Documentation](https://github.com/rubocop/rubocop-ast/blob/master/docs/modules/ROOT/pages/node_pattern.adoc)
