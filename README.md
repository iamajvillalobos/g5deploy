# G5deploy

Utility commands for using kubernetes in g5 projects

## Installation

Install `g5deploy` on your host machine so you can use it on any g5 projects

```bash
gem install g5deploy
```

## Usage

Current features are only `deploy` and `pods`.

- For deploying in staging and production you can use:
```bash
g5deploy deploy <environment>
g5deploy deploy production
g5deploy deploy migration
g5deploy deploy production --with_migration
```

- You can also check current pods:
```bash
g5deploy pods <environment>
g5pods pods production
g5pods pods migration
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/g5deploy. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

