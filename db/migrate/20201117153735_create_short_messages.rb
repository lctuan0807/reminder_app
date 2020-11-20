class CreateShortMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :short_messages do |t|
      t.string :content
      t.string :phone_number, null: false
      t.integer :status, default: 0, null: false
      t.integer :kind, default: 0
      t.datetime :expected_send_date
      t.integer :user_id, null: false
      t.integer :reminder_id

      t.timestamps
    end
  end
end
