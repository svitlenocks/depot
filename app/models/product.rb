class Product < ApplicationRecord
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, :image_url, presence: true
  validates :title, uniqueness: true, length: { minimum: 10 }
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :image_url, allow_blank: true, format: { with: /\.(gif|jpg|png)\Z/i }

  private

  def ensure_not_referenced_by_any_line_item
    return true if line_items.empty?

    errors.add(:base, "line items exist")
    false
  end
end
