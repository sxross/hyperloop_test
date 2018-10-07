class TicketStore < Hyperloop::Store
  state searching: false, reader: true, scope: :class
  state :title, reader: true, scope: :class
  state :description, reader: true, scope: :class
  state :priority, reader: true, scope: :class


  state :user_name, scope: :class, reader: true

end
