# lita-pagerduty-oncall

PagerDuty (http://pagerduty.com) handler for checking who's on call.  

This handler has no external dependancies.  It directly calls the PagerDuty API via HTTPS.  

I created it because the various PagerDuty Lita handlers didn't suppor the functionality we cared about most.  Furthermore I learned that this is because the PagerDuty Ruby Gems they are based on don't implemented it.  Harlan Barnes solved this problem  as well (https://github.com/harlanbarnes/lita-pagerduty, see branch "issue-3") but his patch outputs contact information for persons who are oncall, rather than showing the oncall escalation tree.

This is my first non-trivial Lita Handler, for the time being it is a work in progress.  Be ye thus warned.

## Installation

This handler isn't yet packaged as a Gem.  If you wish to try it, git clone this repo in your Lita directory and add the following line to your Gemfile:

``` ruby
gem "lita-pagerduty-oncall", :path => "lita-pagerduty-oncall/"
```

Then run "bundle install".

## Configuration

Add the following variables to your Lita config file:

``` ruby
config.handlers.pagerduty_oncall.api_key   = ''
config.handlers.pagerduty_oncall.subdomain = ''
```

## Usage

Invoke with the "oncall" command:

```
@BotName oncall
```

Exmaple output seen in room:

```
Testing:
  1: Paul Paulison (static)

Dev Escalation:
  1: Bob Smith (02/02/15 08:00 - 02/09/15 08:00 UTC)

IT Support:
  -- Empty Rotation --

Operations:
  1: Josh Johnson (02/02/15 17:00 - 02/09/15 17:00 UTC)
  2: Ian Iradium (02/02/15 16:00 - 02/09/15 16:00 UTC)
  3: Stephen Summers (02/03/15 02:00 - 02/06/15 02:00 UTC)
```

## License

[MIT](http://opensource.org/licenses/MIT)
