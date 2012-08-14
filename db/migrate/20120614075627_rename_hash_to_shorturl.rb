class RenameHashToShorturl < ActiveRecord::Migration
  def up
    rename_column :urls, :hash, :short_url
  end

  def down
    rename_column :urls, :short_url, :hash
  end
end
