class CreateEpisodes < ActiveRecord::Migration[6.0]
  def change
    create_table :episodes do |t|
      t.string :episode_name
      t.integer :duration
      t.string :description
      t.string :spotify_episode_id
      t.string :img_url
      t.string :show_name
      t.string :spotify_show_id

      t.timestamps
    end
  end
end
