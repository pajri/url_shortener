class CreateUrls < ActiveRecord::Migration[8.0]
  def change
    create_table :urls, id: false, primary_key: :id do |t|
      t.uuid :id, null: false, default: "gen_random_uuid()"
      t.string :long_url
      t.string :short_url
      t.datetime :expiration_date

      t.timestamps
    end
  end
end
