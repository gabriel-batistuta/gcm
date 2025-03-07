require "application_system_test_case"

class MovimentacaosTest < ApplicationSystemTestCase
  setup do
    @movimentacao = movimentacaos(:one)
  end

  test "visiting the index" do
    visit movimentacaos_url
    assert_selector "h1", text: "Movimentacaos"
  end

  test "should create movimentacao" do
    visit movimentacaos_url
    click_on "New movimentacao"

    fill_in "Arma", with: @movimentacao.arma_id
    fill_in "Armeiro", with: @movimentacao.armeiro
    fill_in "Calibre municao", with: @movimentacao.calibre_municao
    fill_in "Data", with: @movimentacao.data
    fill_in "Guarda", with: @movimentacao.guarda_id
    fill_in "Hora", with: @movimentacao.hora
    fill_in "Justificativa", with: @movimentacao.justificativa
    fill_in "Matricula armeiro", with: @movimentacao.matricula_armeiro
    fill_in "Quantidade balas", with: @movimentacao.quantidade_balas
    fill_in "Quantidade carregadores", with: @movimentacao.quantidade_carregadores
    fill_in "Tipo", with: @movimentacao.tipo
    click_on "Create Movimentacao"

    assert_text "Movimentacao was successfully created"
    click_on "Back"
  end

  test "should update Movimentacao" do
    visit movimentacao_url(@movimentacao)
    click_on "Edit this movimentacao", match: :first

    fill_in "Arma", with: @movimentacao.arma_id
    fill_in "Armeiro", with: @movimentacao.armeiro
    fill_in "Calibre municao", with: @movimentacao.calibre_municao
    fill_in "Data", with: @movimentacao.data
    fill_in "Guarda", with: @movimentacao.guarda_id
    fill_in "Hora", with: @movimentacao.hora.to_s
    fill_in "Justificativa", with: @movimentacao.justificativa
    fill_in "Matricula armeiro", with: @movimentacao.matricula_armeiro
    fill_in "Quantidade balas", with: @movimentacao.quantidade_balas
    fill_in "Quantidade carregadores", with: @movimentacao.quantidade_carregadores
    fill_in "Tipo", with: @movimentacao.tipo
    click_on "Update Movimentacao"

    assert_text "Movimentacao was successfully updated"
    click_on "Back"
  end

  test "should destroy Movimentacao" do
    visit movimentacao_url(@movimentacao)
    click_on "Destroy this movimentacao", match: :first

    assert_text "Movimentacao was successfully destroyed"
  end
end
