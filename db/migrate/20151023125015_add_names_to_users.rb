class AddNamesToUsers < ActiveRecord::Migration
  def change
    change_table(:users) do |t|
      t.string          :first_name
      t.string          :family_name
      t.string          :provider,   null:false, default: ""
      t.string          :uid,        null:false, default: ""
      t.integer         :station_id
      t.integer         :ward_id
    end
  end
end
