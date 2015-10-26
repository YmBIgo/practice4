class CreateWards < ActiveRecord::Migration
  def change
    create_table :wards do |t|
      t.string     :name
      t.timestamps null: false
    end
  end
end
