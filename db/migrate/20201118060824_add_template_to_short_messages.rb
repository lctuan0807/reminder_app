class AddTemplateToShortMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :short_messages, :short_messages_template_id, :integer
  end
end
