class Token < ActiveRecord::Base
  validates :value, uniqueness: true
  before_create :generate_hash
  scope :active, -> { where(expired_at: nil) }
  belongs_to :user

  def expire
    self.update_attribute(:expired_at, Time.now)
    self.expired_at
  end

private

  def generate_hash
    begin
      self.value = SecureRandom.hex
    end while self.class.exists?(value: self.value)
  end
end
