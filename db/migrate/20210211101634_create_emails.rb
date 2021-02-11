class CreateEmails < ActiveRecord::Migration[6.0]
  def change
    create_table :emails do |t|
      t.string :email_address
      t.belongs_to :message, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
