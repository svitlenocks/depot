class User < ApplicationRecord
  has_secure_password

  after_destroy :ensure_an_admin_remains

  validates :name, presence: true, uniqueness: true

  private

  def ensure_an_admin_remains
    raise "Last user cannot be deleted" if User.count.zero?
  end
end
