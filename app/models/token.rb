class Token < ActiveRecord::Base
  before_create :generate_hash

private

  def generate_hash
    begin
      self.value = SecureRandom.hex
    end while self.class.exists?(value: self.value)
  end
end
