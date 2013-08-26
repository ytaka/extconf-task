# ExtconfTask

Tiny rake tasks to manage extconf.rb.

## Installation

Add this line to your application's Gemfile:

    gem 'extconf-task'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install extconf-task

## Usage

To define tasks to manage extconf.rb, we write in Rakefile

    require "extconf_task"
    ExtconfTask.new

Then, we can use some tasks, which are displayed by the following command;

    rake -T

## Utility methods

extconf-task includes utility methods to be used in extconf.rb.

The method "find\_header\_in\_gem" provides search direcories of a gem package for a header file.
The following code is the example of extconf.rb to find "ruby_mpfr.h" from directories of gem "ruby-mpfr".

    require "extconf_task/mkmf_utils"
    
    find_header_in_gem("ruby_mpfr.h", "ruby-mpfr")

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
