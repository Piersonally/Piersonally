class Event < ActiveRecord::Base
  belongs_to :actor, class_name: 'User'
  belongs_to :subject, polymorphic: true

  after_create :enqueue_for_publication

  def in_english
    message = ""
    message << "#{actor.email} " if actor
    message << english_event_name
    message << ": #{notes}" if notes
    message
  end

  private

  def enqueue_for_publication
    EventPublishingWorker.perform_in 30.seconds, self.id
  end

  def english_event_name
    self.class.name.demodulize
  end
end
