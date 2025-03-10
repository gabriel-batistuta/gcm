class MovimentacaosController < ApplicationController
  before_action :set_movimentacao, only: %i[ show edit update destroy ]
  layout "movimentacoes"
  
  # GET /movimentacaos or /movimentacaos.json
  def index
    @movimentacaos = Movimentacao.all
    @movimentacao = Movimentacao.new
  end

  # GET /movimentacaos/1 or /movimentacaos/1.json
  def show
  end

  # GET /movimentacaos/new
  def new
    @movimentacao = Movimentacao.new
  end

  # GET /movimentacaos/1/edit
  def edit
  end

  # POST /movimentacaos or /movimentacaos.json
  def create
    @movimentacao = Movimentacao.new(movimentacao_params)
    arma = Arma.find_by(id: @movimentacao.arma_id)
  
    if @movimentacao.tipo.downcase == "empréstimo"
      if arma&.emprestada
        respond_to do |format|
          format.html { redirect_to movimentacaos_path, alert: "Esta arma já está emprestada e não pode ser emprestada novamente." }
          format.json { render json: { error: "Esta arma já está emprestada." }, status: :unprocessable_entity }
        end
        return
      end
    elsif @movimentacao.tipo.downcase == "devolução"
      ultima_movimentacao = Movimentacao.where(arma_id: @movimentacao.arma_id)
                                        .where(tipo: "Empréstimo")
                                        .order(created_at: :desc)
                                        .first
  
      if ultima_movimentacao.nil? || ultima_movimentacao.guarda_id != @movimentacao.guarda_id
        respond_to do |format|
          format.html { redirect_to movimentacaos_path, alert: "A arma não pode ser devolvida porque não foi emprestada ou não foi retirada por este guarda." }
          format.json { render json: { error: "A arma não pode ser devolvida porque não foi emprestada ou não foi retirada por este guarda." }, status: :unprocessable_entity }
        end
        return
      end
  
      # Verifica diferença nas quantidades de balas e carregadores
      balas_diferenca = ultima_movimentacao.quantidade_balas.to_i - @movimentacao.quantidade_balas.to_i
      carregadores_diferenca = ultima_movimentacao.quantidade_carregadores.to_i - @movimentacao.quantidade_carregadores.to_i
  
      if (balas_diferenca > 0 || carregadores_diferenca > 0) && @movimentacao.justificativa.blank?
        respond_to do |format|
          format.html { redirect_to movimentacaos_path, alert: "A devolução apresenta falta de balas ou carregadores. Justificativa obrigatória!" }
          format.json { render json: { error: "Justificativa obrigatória para devolução com falta de balas ou carregadores." }, status: :unprocessable_entity }
        end
        return
      end
    end
  
    respond_to do |format|
      if @movimentacao.save
        atualizar_status_arma(@movimentacao)
        format.html { redirect_to movimentacaos_path, notice: "Movimentação criada com sucesso." }
        format.json { render :show, status: :created, location: @movimentacao }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movimentacao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movimentacaos/1 or /movimentacaos/1.json
  def update
    respond_to do |format|
      if @movimentacao.update(movimentacao_params)
        atualizar_status_arma(@movimentacao)
        format.html { redirect_to movimentacaos_path, notice: "Movimentação atualizada com sucesso." }
        format.json { render :show, status: :ok, location: @movimentacao }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movimentacao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movimentacaos/1 or /movimentacaos/1.json
  def destroy
    @movimentacao.destroy!
    respond_to do |format|
      format.html { redirect_to movimentacaos_path, status: :see_other, notice: "Movimentação foi deletada com sucesso." }
      format.json { head :no_content }
    end
  end

  def ultima_movimentacao
    movimentacao = Movimentacao.where(arma_id: params[:arma_id])
                               .order(created_at: :desc)
                               .first
  
    if movimentacao
      render json: {
        quantidade_balas: movimentacao.quantidade_balas,
        quantidade_carregadores: movimentacao.quantidade_carregadores
      }
    else
      render json: { quantidade_balas: 0, quantidade_carregadores: 0 }
    end
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movimentacao
      @movimentacao = Movimentacao.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def movimentacao_params
      params.require(:movimentacao).permit(
        :guarda_id,
        :matricula_armeiro,
        :data,
        :hora,
        :tipo,
        :arma_id,
        :quantidade_balas,
        :calibre_municao,
        :quantidade_carregadores,
        :justificativa
      )
    end

    def atualizar_status_arma(movimentacao)
      return unless movimentacao.arma_id.present?

      arma = Arma.find(movimentacao.arma_id)
      if movimentacao.tipo.downcase == "empréstimo"
        arma.update(emprestada: true)
      elsif movimentacao.tipo.downcase == "devolução"
        arma.update(emprestada: false)
      end
    end
end