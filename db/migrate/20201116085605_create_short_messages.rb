class CreateShortMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :short_messages do |t|
      t.string :content
      t.string :phone_number
      t.integer :status
      t.integer :kind
      t.integer :user_id
    end
  end
end
