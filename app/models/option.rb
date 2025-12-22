class Option < ApplicationRecord
  belongs_to :question, counter_cache: true
  validates :content, presence: true
end
