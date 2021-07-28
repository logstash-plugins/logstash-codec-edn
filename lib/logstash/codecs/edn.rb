require "logstash/codecs/base"
require "logstash/util"

require 'logstash/plugin_mixins/event_support/event_factory_adapter'
require 'logstash/plugin_mixins/validator_support/field_reference_validation_adapter'

class LogStash::Codecs::EDN < LogStash::Codecs::Base

  extend LogStash::PluginMixins::ValidatorSupport::FieldReferenceValidationAdapter

  include LogStash::PluginMixins::EventSupport::EventFactoryAdapter

  config_name "edn"

  # Defines a target field for placing decoded fields.
  # If this setting is omitted, data gets stored at the root (top level) of the event.
  #
  # NOTE: the target is only relevant while decoding data into a new event.
  config :target, :validate => :field_reference

  def register
    require "edn"
  end

  public
  def decode(data)
    begin
      yield targeted_event_factory.new_event(EDN.read(data))
    rescue => e
      @logger.warn("EDN parse failure. Falling back to plain-text", :error => e, :data => data)
      yield event_factory.new_event("message" => data)
    end
  end

  public
  def encode(event)
    # use normalize to make sure returned Hash is pure Ruby
    # #to_edn which relies on pure Ruby object recognition
    data = LogStash::Util.normalize(event.to_hash)
    # timestamp is serialized as a iso8601 string
    # merge to avoid modifying data which could have side effects if multiple outputs
    @on_event.call(event, data.merge(LogStash::Event::TIMESTAMP => event.timestamp.to_iso8601).to_edn)
  end

end
