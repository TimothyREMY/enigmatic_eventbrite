class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.references :admin, index: true
      t.datetime :start_date
      t.integer :duration
      t.text :description
      t.string :title
      t.integer :price
      t.string :location

      t.timestamps
    end
  end
end
