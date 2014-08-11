class EventPublishingWorker
  include Sidekiq::Worker

  def perform(event_id)
    begin
      @event = Event.find event_id
      publish_event
    rescue ActiveRecord::RecordNotFound
      # ignore
    end
  end

  private

  def publish_event
    hipchat_api['Piersonally'].send "piersonally.com", @event.in_english, color: color
  end

  def color
    case @event.metadata[:log_level]
    when :alert ; 'red'
    when :info  ; 'green'
    when :debug ; 'gray'
    else
      'yellow'
    end
  end

  def hipchat_api
    @api_client ||= HipChat::Client.new hipchat_api_token, api_version: 'v2'
  end

  def hipchat_api_token
    ENV['HIPCHAT_API_TOKEN'] ||
    Rails.application.secrets.hipchat_api_token
  end
end
