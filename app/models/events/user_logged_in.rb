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
  class UserLoggedIn < ::Event

    validates :actor_id, presence: true

    def in_english
      "#{actor.username} (#{actor.email}) logged in"
    end

    def should_publish?
      true
    end
  end
end
