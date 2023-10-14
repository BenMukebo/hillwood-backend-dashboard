class Role < ApplicationRecord
  enum name: {
    user: 0,
    admin: 1,
    subscriber: 2
  }.freeze, _prefix: true
end
