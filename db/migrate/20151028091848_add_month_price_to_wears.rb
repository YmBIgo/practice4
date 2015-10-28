class AddMonthPriceToWears < ActiveRecord::Migration
  def change
    add_column :wears, :month_price, :integer, null: false
  end
end
