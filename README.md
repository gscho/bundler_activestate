# Activestate Bundler Plugin

The ActiveState bundler plugin extends the functionality of the bundler CLI using the `state` tool.

It adds the following commands which are closely related to the existing bundler commands `install`, `add`, and `remove`.

```bash
state-install
state-add
state-remove
```

## Installation

The recommended way to install this plugin is:

    $ bundle plugin install bundler_activestate --git https://github.com/gscho/bundler_activestate.git

## Usage

### state-install

Generates a `Gemfile.lock`, imports it into the state and optionally pushes it to the ActiveState platform.

```bash
bundle state-install [--[no-]force]
                     [--[no-]push]
```

### state-add

Adds a gem to the `Gemfile`, generates a `Gemfile.lock`, imports it into the state and optionally pushes it to the ActiveState platform.

```bash
bundle state-add [--[no-]force]
                 [--[no-]push]
```

### state-remove

Removes a gem(s) from the `Gemfile`, generates a `Gemfile.lock`, imports it into the state and optionally pushes it to the ActiveState platform.

```bash
bundle state-remove [--[no-]force]
                    [--[no-]push]
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the BundlerActivestate project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/bundler_activestate/blob/main/CODE_OF_CONDUCT.md).
