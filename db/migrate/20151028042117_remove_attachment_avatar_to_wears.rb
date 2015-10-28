class RemoveAttachmentAvatarToWears < ActiveRecord::Migration
  def change
    remove_attachment :wears, :avatar
  end
end
