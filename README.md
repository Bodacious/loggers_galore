# LoggersGalore

Need more loggers? Loggers Galore allows you to create as many loggers as you require and access them anyplace in your app.


# Example

To create a log for sessions and a log for user behavior:

Add a file to <em>/initializers</em> called <b>loggers_galore.rb</b> (or any other name)

In this file you can specify all of the loggers you require like so:
  <tt>Rails.extra_loggers = [:session, :user]</tt>

This will create two files in the <em>/log</em> directory called <b>session.log</b> and <b>user.log</b> and add two methods, <b>session_logger</b> and <b>user_logger</b> which can be called anyplace in your app.

All of the usual logger methods apply; debug, info, warn, error, fatal, unknown.

All feedback welcome: dr_gavin@hotmail.com

Copyright (c) 2009 Gavin Morrice, released under the MIT license
