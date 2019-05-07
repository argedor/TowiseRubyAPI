
# TOWISE RUBY API
Towise assists you to detect human faces and bodies with using the latest and reliable technology.

## Getting Started
### Prerequisites 
```
ruby 2.6.3
gem 3.0.3

```
### Installing
To install the package

```sh
gem install towise 
```
To import your project
```ruby
require "towise"
```
### Using Towise
You must enter appKey and appId

For Example:
```ruby
require "towise"

image_url = "https://cdn.onebauer.media/one/media/5c6e/80bc/d007/9656/5f0a/6c12/dua-lipa-brits.jpg"
t = Towise::API.new({"appid"=>"your appId","appkey"=>"your appKey"})
puts t.faceDetect(image_url)
```

## Versioning
For the versions available, see the https://github.com/argedor/TowiseNodeJSAPI/tags

## Authors
* **Harun Keleşoğlu** - *Developer* - [Github](https://github.com/harunkelesoglu)
See also the list of [contributers](https://github.com/argedor/TowiseNodeJSAPI/graphs/contributors)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
