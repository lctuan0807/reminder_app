class CreateReminders < ActiveRecord::Migration[6.0]
  def change
    create_table :reminders do |t|
      t.string :title
      t.string :comment
      t.datetime :schedule_date
      t.integer  :user_id

      t.timestamps
    end
  end
end
