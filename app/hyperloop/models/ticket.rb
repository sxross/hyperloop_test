class Ticket < ApplicationRecord
  regulate_scope :all
  scope :by_priority, -> { order('priority', 'created_at DESC') }
  scope :open_items, -> { where(closed_at: nil) }
  scope :by_open_and_priority, -> { order('closed_at', 'priority', 'created_at DESC') }

  def closed?
    closed_at != nil
  end

end


module Hyperloop
  def self.on_error(err, reason, details)
    p err
    p reason
    p details
  end
end
