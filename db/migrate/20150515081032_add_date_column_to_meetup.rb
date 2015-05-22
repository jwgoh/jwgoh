class AddDateColumnToMeetup < ActiveRecord::Migration
  def change
    add_column :meetups, :date, :date, null: false
    execute "UPDATE meetups SET date = '#{Date.current.to_s(:db)}' "
  end
end
