class CreateMovimentacaos < ActiveRecord::Migration[8.0]
  def change
    create_table :movimentacaos do |t|
      t.string :armeiro
      t.string :matricula_armeiro
      t.date :data
      t.time :hora
      t.string :tipo
      t.references :arma, null: false, foreign_key: true
      t.integer :quantidade_balas
      t.string :calibre_municao
      t.integer :quantidade_carregadores
      t.references :guarda, null: false, foreign_key: true
      t.text :justificativa

      t.timestamps
    end
  end
end
