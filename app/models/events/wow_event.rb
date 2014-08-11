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
  end
end
