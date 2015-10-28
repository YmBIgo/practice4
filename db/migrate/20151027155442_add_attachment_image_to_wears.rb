class AddAttachmentImageToWears < ActiveRecord::Migration
  def self.up
    change_table :wears do |t|
      t.has_attached_file :wimage
    end
  end

  def self.down
    drop_attached_file :wears, :wimage
  end
end
