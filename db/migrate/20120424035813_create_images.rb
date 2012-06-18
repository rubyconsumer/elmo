class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :url
      t.text :content

      t.timestamps
    end
  end
end
