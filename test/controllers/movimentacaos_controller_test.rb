require "test_helper"

class MovimentacaosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @movimentacao = movimentacaos(:one)
  end

  test "should get index" do
    get movimentacaos_url
    assert_response :success
  end

  test "should get new" do
    get new_movimentacao_url
    assert_response :success
  end

  test "should create movimentacao" do
    assert_difference("Movimentacao.count") do
      post movimentacaos_url, params: { movimentacao: { arma_id: @movimentacao.arma_id, armeiro: @movimentacao.armeiro, calibre_municao: @movimentacao.calibre_municao, data: @movimentacao.data, guarda_id: @movimentacao.guarda_id, hora: @movimentacao.hora, justificativa: @movimentacao.justificativa, matricula_armeiro: @movimentacao.matricula_armeiro, quantidade_balas: @movimentacao.quantidade_balas, quantidade_carregadores: @movimentacao.quantidade_carregadores, tipo: @movimentacao.tipo } }
    end

    assert_redirected_to movimentacao_url(Movimentacao.last)
  end

  test "should show movimentacao" do
    get movimentacao_url(@movimentacao)
    assert_response :success
  end

  test "should get edit" do
    get edit_movimentacao_url(@movimentacao)
    assert_response :success
  end

  test "should update movimentacao" do
    patch movimentacao_url(@movimentacao), params: { movimentacao: { arma_id: @movimentacao.arma_id, armeiro: @movimentacao.armeiro, calibre_municao: @movimentacao.calibre_municao, data: @movimentacao.data, guarda_id: @movimentacao.guarda_id, hora: @movimentacao.hora, justificativa: @movimentacao.justificativa, matricula_armeiro: @movimentacao.matricula_armeiro, quantidade_balas: @movimentacao.quantidade_balas, quantidade_carregadores: @movimentacao.quantidade_carregadores, tipo: @movimentacao.tipo } }
    assert_redirected_to movimentacao_url(@movimentacao)
  end

  test "should destroy movimentacao" do
    assert_difference("Movimentacao.count", -1) do
      delete movimentacao_url(@movimentacao)
    end

    assert_redirected_to movimentacaos_url
  end
end
