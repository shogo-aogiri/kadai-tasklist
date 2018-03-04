class AddStatusToTask < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :status, :references
  end
end
