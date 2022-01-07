class Contact < ApplicationRecord
  validates :category, presence: true
  validates :message, presence: true, length: { maximum: 1000 }
end
