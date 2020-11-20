class CreateReminders < ActiveRecord::Migration[6.0]
  def change
    create_table :reminders do |t|
      t.string :title
      t.integer :due_after, null: false
      t.integer :sms_template_id

      t.timestamps
    end
  end
end
