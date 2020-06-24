class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :note
      t.references :user
      t.references :episode
      t.string :start_timestamp

      t.timestamps
    end
  end
end
