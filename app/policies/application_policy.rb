# app/policies/application_policy

# Policies regulate access to your public models
# The following policy will open up full access (but only in development)
# The policy system is very flexible and powerful.  See the documentation
# for complete details.
class Hyperloop::ApplicationPolicy
  # Allow any session to connect:
  always_allow_connection
  # Send all attributes from all public models
  regulate_all_broadcasts { |policy| policy.send_all }
  # Allow all changes to public models
  allow_change(to: :all, on: [:create, :update, :destroy]) { true }
end unless Rails.env.production?

class UserPolicy # defines policies for the User class
  # The regulate_instance_connections method enables instances of the User
  # class to be treated as a channel.

  # The policy is defined by a block that is executed in the context of the
  # current acting_user.

  # For our User instance connection the policy is that there must be a
  # logged-in user, and the connection is made to that user:
  regulate_instance_connections { self }
  # If there is no logged in user self will be nil, and no connection will be
  # made.
end

class TicketPolicy
  regulate_instance_connections { tickets }
end
