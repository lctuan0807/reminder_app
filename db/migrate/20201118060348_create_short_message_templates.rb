class CreateShortMessageTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :short_message_templates do |t|
      t.string :name
      t.string :content
      t.boolean :enabled

      t.timestamps
    end
  end
end
