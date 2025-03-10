class GuardasController < ApplicationController
  before_action :set_guarda, only: %i[ show edit update destroy ]
  layout "guardas"
  # GET /guardas or /guardas.json
  def index
    @guardas = Guarda.all
    @guarda = Guarda.new
  end

  # GET /guardas/1 or /guardas/1.json
  def show
  end

  # GET /guardas/new
  def new
    @guarda = Guarda.new
  end

  # GET /guardas/1/edit
  def edit
  end

  # POST /guardas or /guardas.json
  def create
    @guarda = Guarda.new(guarda_params)

    respond_to do |format|
      if @guarda.save
        format.html { redirect_to guardas_path, notice: "Guarda criado com sucesso!" }
        format.json { render :show, status: :created, location: @guarda }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @guarda.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /guardas/1 or /guardas/1.json
  def update
    respond_to do |format|
      if @guarda.update(guarda_params)
        format.html { redirect_to guardas_path, notice: "Guarda atualizado com sucesso!" }
        format.json { render :show, status: :ok, location: @guarda }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @guarda.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guardas/1 or /guardas/1.json
  def destroy
    @guarda.destroy!

    respond_to do |format|
      format.html { redirect_to guardas_path, status: :see_other, notice: "Guarda apagado com sucesso!" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guarda
      @guarda = Guarda.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def guarda_params
      params.expect(guarda: [ :nome_completo, :matricula, :numeracao_porte, :equipe_id ])
    end
end
