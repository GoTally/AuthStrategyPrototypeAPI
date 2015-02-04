class Token < ActiveRecord::Base
  before_create :generate_hash

  scope :active, -> { where(expired_at: nil) }

  validates :value, uniqueness: true

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
