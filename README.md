# LanguageTool SRX for Ruby

This gem provides SRX segmentation rules from
[LanguageTool](https://languagetool.org/). It is a companion to
[srx-ruby](https://github.com/amake/srx-ruby), which implements an SRX engine to
apply these rules for segmenting text.

For details, please see [srx-ruby](https://github.com/amake/srx-ruby).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'srx-languagetool'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install srx-languagetool

## Usage

For detailed usage information, please see
[srx-ruby](https://github.com/amake/srx-ruby).

```ruby
require 'srx-languagetool'

data = Srx::Data.languagetool
engine = Srx::Engine.new(data)
engine.segment('Hi. How are you?', language: 'en') #=> ["Hi.", " How are you?"]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake test` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and the created tag, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/amake/srx-languagetool.

## License

The gem is available as open source under the terms of the [GNU Lesser General
Public License, version 2.1](https://opensource.org/licenses/LGPL-2.1).
