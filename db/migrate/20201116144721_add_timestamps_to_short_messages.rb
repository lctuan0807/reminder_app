class AddTimestampsToShortMessages < ActiveRecord::Migration[6.0]
  def change
    add_timestamps(:short_messages)
  end
end
