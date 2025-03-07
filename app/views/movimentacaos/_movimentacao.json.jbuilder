json.extract! movimentacao, :id, :armeiro, :matricula_armeiro, :data, :hora, :tipo, :arma_id, :quantidade_balas, :calibre_municao, :quantidade_carregadores, :guarda_id, :justificativa, :created_at, :updated_at
json.url movimentacao_url(movimentacao, format: :json)
