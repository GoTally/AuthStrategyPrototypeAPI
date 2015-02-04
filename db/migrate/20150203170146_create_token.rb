class CreateToken < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.string :value
      t.datetime :expired_at, default: nil

      t.timestamps 
    end
  end
end
