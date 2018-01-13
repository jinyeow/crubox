# Crubox

Crystal Utility Toolbox.

A bunch of help scripts and snippets that are too small for their own
project, but need somewhere to live.

May include:
  * algorithms
  * scripts
  * useful classes/modules

## Installation

```
$ # clone the repo
$ git clone https://github.com/jinyeow/crubox
$
$ # create bin/ directory if it doesn't exist
$ mkdir bin
$
$ # run tests
$ crystal spec
$
$ # if tests pass
$ make all
$
```

All the tools should be available in the `bin` directory.

Just copy them into your $PATH to use them.

## Usage

For the up_or_down tool:
```
$ up_or_down "www.webnovel.com"
www.webnovel.com is up
```

For the netgeo tool:
```
$ # Some examples
$ netgeo --wan
$ netgeo --router
$ netgeo --geo
```

See `netgeo --help` for more options.

## Contributing

1. Fork it ( https://github.com/jinyeow/crubox/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [jinyeow](https://github.com/jinyeow) - creator, maintainer
