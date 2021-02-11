class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.string :url
      t.belongs_to :message, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
