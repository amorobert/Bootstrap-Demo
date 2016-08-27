class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.integer :post_id
      t.integer :commenter_iddbmigrategbddd

      t.timestamps(null: false)
    end


  end
end
