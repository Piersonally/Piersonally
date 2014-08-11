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

module Events
  class WowEvent < ::Event

    def in_english
      notes
    end

    def should_publish?
      if metadata[:log_level]
        [:info, :alert].include? metadata[:log_level]
      else
        true
      end
    end
  end
end
