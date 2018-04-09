# Splunk Logging for Java Changelog

## Version 1.5.2
* Enable the configured _layout_ to write the entire `event` and not just the `event.message`.
  This allows for the layout to add new fields, such as method name, ...

## Version 1.5.1

* Fix issues with Logback 1.1.x, see GitHub issue [#16](https://github.com/splunk/splunk-library-javalogging/issues/21).

## Version 1.5.0

* Add support for HTTP Event Collector.

## Version 1.0.1

* Add fix for hanging logback thread in `TcpAppender`.

## Version 1.0.0

Initial Splunk Logging for Java release.
