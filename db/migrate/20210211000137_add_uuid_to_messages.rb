class AddUuidToMessages < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'uuid-ossp'

    add_column :messages, :uuid, :uuid, default: "uuid_generate_v4()", null: false

     change_table :messages do |t|
       t.remove :id
       t.rename :uuid, :id
     end

     execute "ALTER TABLE messages ADD PRIMARY KEY (id);"
  end
end
