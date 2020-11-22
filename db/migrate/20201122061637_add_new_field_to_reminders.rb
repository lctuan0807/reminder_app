class AddNewFieldToReminders < ActiveRecord::Migration[6.0]
  def change
    add_column :reminders, :period_type, :string
    rename_column :reminders, :due_after, :period
  end
end
