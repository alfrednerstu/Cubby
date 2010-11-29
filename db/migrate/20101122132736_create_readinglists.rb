class CreateReadinglists < ActiveRecord::Migration
  def self.up
    create_table :readinglists do |t|
      t.integer :user_id
      t.integer :article_id

      t.timestamps
    end
  end

  def self.down
    drop_table :readinglists
  end
end
