## 3.1.1
  - Fix `NameError: uninitialized constant Bignum` that prevented the codec from loading on Logstash 9.4+ [#8](https://github.com/logstash-plugins/logstash-codec-edn/pull/8)
    - The `edn` gem references the `Bignum` constant, which Ruby removed in 3.2 (shipped by the JRuby in Logstash 9.4+). This raised a `NameError` when the codec registered, so any pipeline using the `edn` codec failed to start. Alias the removed `Fixnum`/`Bignum` constants to `Integer` before requiring `edn`.

## 3.1.0
  - Feat: target configuration + event-factory support [#6](https://github.com/logstash-plugins/logstash-codec-edn/pull/6)

## 3.0.6
  - Update gemspec summary

## 3.0.5
  - Fix some documentation issues

## 3.0.4
  - Docs: Add plugin description  
## 3.0.3
  - Remove milestone option
## 3.0.2
  - Relax constraint on logstash-core-plugin-api to >= 1.60 <= 2.99
## 3.0.1
  - Republish all the gems under jruby.
## 3.0.0
  - Update the plugin to the version 2.0 of the plugin api, this change is required for Logstash 5.0 compatibility. See https://github.com/elastic/logstash/issues/5141
# 2.0.4
  - Depend on logstash-core-plugin-api instead of logstash-core, removing the need to mass update plugins on major releases of logstash
# 2.0.3
  - New dependency requirements for logstash-core for the 5.0 release
## 2.0.0
 - Plugins were updated to follow the new shutdown semantic, this mainly allows Logstash to instruct input plugins to terminate gracefully, 
   instead of using Thread.raise on the plugins' threads. Ref: https://github.com/elastic/logstash/pull/3895
 - Dependency on logstash-core update to 2.0

