class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :url
      t.string :hash

      t.timestamps
    end
    execute "SELECT setval('urls_id_seq', 1000);"
  end
end
