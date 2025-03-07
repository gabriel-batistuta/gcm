# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_03_07_225717) do
  create_table "armas", force: :cascade do |t|
    t.string "modelo"
    t.string "registro"
    t.boolean "emprestada"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "guarda_emprestado_id"
  end

  create_table "equipes", force: :cascade do |t|
    t.string "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "guardas", force: :cascade do |t|
    t.string "nome_completo"
    t.string "matricula"
    t.string "numeracao_porte"
    t.integer "equipe_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipe_id"], name: "index_guardas_on_equipe_id"
  end

  create_table "movimentacaos", force: :cascade do |t|
    t.string "armeiro"
    t.string "matricula_armeiro"
    t.date "data"
    t.time "hora"
    t.string "tipo"
    t.integer "arma_id", null: false
    t.integer "quantidade_balas"
    t.string "calibre_municao"
    t.integer "quantidade_carregadores"
    t.integer "guarda_id", null: false
    t.text "justificativa"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["arma_id"], name: "index_movimentacaos_on_arma_id"
    t.index ["guarda_id"], name: "index_movimentacaos_on_guarda_id"
  end

  create_table "unidades", force: :cascade do |t|
    t.string "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.boolean "admin", default: false
    t.boolean "temporary", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_token"
    t.datetime "reset_sent_at"
  end

  add_foreign_key "guardas", "equipes"
  add_foreign_key "movimentacaos", "armas"
  add_foreign_key "movimentacaos", "guardas"
end
