module Events
  class UserLoggedIn < ::Event

    validates :actor_id, presence: true

    def in_english
      "#{actor.username} (#{actor.email}) logged in"
    end
  end
end
