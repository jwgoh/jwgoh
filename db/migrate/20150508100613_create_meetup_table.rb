class CreateMeetupTable < ActiveRecord::Migration
  def change
    create_table :meetups do |t|
      t.string :title
      t.text :description
    end
  end
end
