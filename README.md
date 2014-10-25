# WiserTimezone

Friendly Timezone on Steroids

## Requirements

_WiserTimezone_ only support Rails >= 3.2 with jQuery.

## Setup

### Gem Installation

You can do normal gem installation for `wiser_timezone` from your terminal:

    gem install wiser_timezone

or add this line in your Gemfile:

    gem 'wiser_timezone', '~> 0.1.9'

Be sure to restart your application if it is already running.

### Database (optional)

**Note:**
Use the database migration **ONLY** if you have `users` database table and `current_user` helper method.

Generate a migration for wiser_timezone and run the database migration (in your Rails project):

    rails g wiser_timezone:migration
    rake db:migrate

## Installation

### Javascript

Include the `wiser_timezone` javascript into your `app/assets/javascripts/application.js`:

	//= require jquery
	//= require wiser_timezone

Reload using the `wiser_timezone_reload()` function from your javascript `ready` event:

	$(document).ready(function(){
	  wiser_timezone_reload();
	})

### Turbolinks (optional)

Reload using the `wiser_timezone_reload()` function from your javascript `page:load` event:

	$(document).on("page:load", function(){
	  wiser_timezone_reload();
	})

### Stylesheet

Include the `wiser_timezone` stylesheet into your `app/assets/stylesheets/application.css`:

	*= require wiser_timezone

### Initialize

Render the `wiser_timezone_initialize` view below the `body` of your layout file:

	<body>
	  <%= wiser_timezone_initialize %>
	  <!-- More Codes -->
	</body>

You can use the `force` parameter to require the user to set the timezone before using the application.

	<body>
	  <%= wiser_timezone_initialize(force: true) %>
	  <!-- More Codes -->
	</body>

You can use the `auto_set_guest` parameter to automatically capture the timezone if the user is not logged in. In this way, the guest users will never be asked to set their timezone, the system timezone will automatically detected.

	<body>
	  <%= wiser_timezone_initialize(force: true, auto_set_guest: true) %>
	  <!-- More Codes -->
	</body>


## Usage

All dates must be printed using the custom helper `wiser_timezone()` or `wt()`.

### Basic Usage

Here's how to apply the timezone in a Date object:

	<%= wiser_timezone(@post.created_at) %>
	// Return: 2014-03-15 02:37:07 +0800

Or use the simplier `wt` method:

	<%= wt(@post.created_at) %>
	// Return: 2014-03-15 02:37:07 +0800

Then you can also format the value:

	<%= wt(@post.created_at).strftime('%Y-%m-%d %H:%M:%S') %>
	// Return: 2014-03-15 02:37:07

### Globalize

Enable the *WiserTimezone* in the entire application by adding the `ensure_timezone` method as a `before_filter` of your `ApplicationController`:

	include WiserTimezone::WiserTimezoneHelper
	class ApplicationController < ActionController::Base
		before_filter :ensure_timezone
		# More Codes
	end

### Date Only

You can convert dates to timezone without having the time, in short, date only:

	<%= wiser_timezone(@post.created_at, date_only: true) %>
	// Output: 2014-03-15 00:00:00 +0800


### Reset Link

You can embed a link in your app to clear or reset the current settings:

	<%= link_to "Reset Timezone", set_timezone_path(offset: 'clear') %>

### Extra

You can get the current timezone in basic format using the `current_timezone` method:

	My timezone is:
	<%= current_timezone %>
	// Output: (GMT+08:00) Beijing

You can get the current timezone in slim format using the `current_timezone_slim` method:

	My timezone is:
	<%= current_timezone_slim %>
	// Output: (GMT+8) Beijing

You can get the current timezone location using the `current_timezone_location` method:

	My timezone is:
	<%= current_timezone_location %>
	// Output: Beijing

You can get the current timezone offset in basic format using the `current_timezone_offset` method:

	My timezone is:
	<%= current_timezone_offset %>
	// Output: GMT+8

You can get the current timezone offset in slim format using the `current_timezone_offset` method:

	My timezone is:
	<%= current_timezone_offset_slim %>
	// Output: +8

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Support
Open an issue in https://github.com/kennethjohnbalgos/wiser_timezone if you need further support or want to report a bug.

## License

The MIT License (MIT) Copyright (c) 2014 iKennOnline

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
