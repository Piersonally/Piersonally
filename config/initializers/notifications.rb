ActiveSupport::Notifications.subscribe(/com\.piersonally\.wow\..*/) do |name, start, finish, id, payload|
  Events::WowEvent.create! notes: "#{name}: #{payload[:message]}"
end
