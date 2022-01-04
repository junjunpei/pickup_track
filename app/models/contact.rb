class Contact < ApplicationRecord
  validates :email, allow_nil: true
  validates :category, presence: true
  validates :message, presence: true, length: { maximum: 1000 }
end
