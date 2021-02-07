class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :messages, id: :uuid do |t|
      t.text :text

      t.timestamps
    end
  end
end
