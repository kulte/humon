class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :address
      t.datetime :ended_at
      t.decimal :lat
      t.decimal :lng
      t.string :name
      t.datetime :started_at

      t.timestamps
    end
  end
end
