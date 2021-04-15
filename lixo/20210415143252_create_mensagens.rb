class CreateMensagens < ActiveRecord::Migration[6.0]
  def change
    create_table :mensagens do |t|
      t.string :titulo
      t.text :corpo

      t.timestamps
    end
  end
end
