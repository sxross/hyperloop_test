class Ticket < ApplicationRecord
  regulate_scope :all
  # scope :by_priority, -> { order('priority DESC') }  ### Uncomment for bug
end


module Hyperloop
  def self.on_error(err, reason, details)
    # do whatever you want here... i.e. log, debug, etc
  end
end
