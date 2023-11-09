class RenameNameToCollegeName < ActiveRecord::Migration[7.0]
  def change
    rename_column :colleges, :name, :college_name
  end
end
