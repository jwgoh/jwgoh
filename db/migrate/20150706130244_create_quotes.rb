class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|

      t.string :text
      t.timestamps null: false
    end
  end
end
