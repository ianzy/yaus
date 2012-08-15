class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls, :options => "AUTO_INCREMENT = 1000" do |t|
      t.string :url
      t.string :hash

      t.timestamps
    end
  end
end
