class CreateWears < ActiveRecord::Migration
  def change
    create_table :wears do |t|
      t.integer       :price
      t.integer       :brand_id
      t.integer       :user_id
      t.boolean       :rent_or_not, default: false, null: false
      t.timestamps null: false
    end
  end
end
