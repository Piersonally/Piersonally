ActiveSupport::Notifications.subscribe(/com\.piersonally\.wow\..*/) do |name, start, finish, id, payload|
  message = payload.delete :message
  Events::WowEvent.create! notes: "#{name}: #{message}", metadata: payload
end
