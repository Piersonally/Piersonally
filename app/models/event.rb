# == Schema Information
#
# Table name: events
#
#  id           :integer          not null, primary key
#  type         :string(255)
#  actor_id     :integer
#  subject_id   :integer
#  subject_type :string(255)
#  notes        :text
#  created_at   :datetime
#  updated_at   :datetime
#  metadata     :text             default("--- {}\n")
#

class Event < ActiveRecord::Base
  belongs_to :actor, class_name: 'User'
  belongs_to :subject, polymorphic: true

  serialize :metadata

  after_create :enqueue_for_publication

  def in_english
    message = ""
    message << "#{actor.email} " if actor
    message << english_event_name
    message << ": #{notes}" if notes
    message
  end

  def should_publish? # Override in subclasses
    false
  end

  private

  def enqueue_for_publication
    EventPublishingWorker.perform_in 30.seconds, self.id if should_publish?
  end

  def english_event_name
    self.class.name.demodulize
  end
end
