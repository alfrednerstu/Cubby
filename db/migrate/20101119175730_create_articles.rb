class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :title
      t.string :url
      t.text :content
      #t.references :user
      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
