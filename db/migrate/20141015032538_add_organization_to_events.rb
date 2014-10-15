class AddOrganizationToEvents < ActiveRecord::Migration
  def change
    add_column :events, :organization, :string
  end
end
