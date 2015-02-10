class Token < ActiveRecord::Base
  validates :value, uniqueness: true
  before_create :generate_hash
  scope :active, -> { where(expired_at: nil) }
  belongs_to :user

  def self.hash_active?(hash)
    Token.active.map(&:value).include?(hash)
  end

  def expire
    self.update_attribute(:expired_at, Time.now)
    self.expired_at
  end

  def expired?
    !self.expired_at.nil?
  end

private

  def generate_hash
    begin
      self.value = SecureRandom.hex
    end while self.class.exists?(value: self.value)
  end
end
