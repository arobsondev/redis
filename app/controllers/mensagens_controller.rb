class MensagensController < ApplicationController
  before_action :set_mensagem, only: %i[ show edit update destroy ]

  # GET /mensagens or /mensagens.json
  def index
    @mensagens = {}
    keys = REDIS_CLIENT.keys '*'
    keys.each do |key|
      @mensagens[:"#{key}"] = REDIS_CLIENT.get(key)
    end
  end

  # GET /mensagens/1 or /mensagens/1.json
  def show
  end

  # GET /mensagens/new
  def new
  end

  # GET /mensagens/1/edit
  def edit
  end

  # POST /mensagens or /mensagens.json
  def create
    @key = params[:titulo]
    @mensagem = params[:corpo]

    respond_to do |format|
      if !REDIS_CLIENT.exists?(params[:titulo])
        REDIS_CLIENT.set(@key, @mensagem)
        format.html { redirect_to mensagem_path(@key), notice: "Mensagem foi criado com sucesso" }
      else
        format.html { redirect_to mensagens_path, notice: "Erro ao criar, esse título já existe!" }
      end
    end
  end

  # PATCH/PUT /mensagens/1 or /mensagens/1.json
  def update
    respond_to do |format|
      if !REDIS_CLIENT.exists?(params[:titulo]) or @key == params[:titulo]

        REDIS_CLIENT.del(@key)

        @key = params[:titulo]
        @mensagem = params[:corpo]
        REDIS_CLIENT.set(@key, @mensagem)

        format.html { redirect_to mensagem_path(@key), notice: "Mensagem foi alterada com sucesso" }
      else
        format.html { redirect_to mensagens_path, notice: "Erro ao alterar, esse título já existe!" }
      end
    end
  end

  # DELETE /mensagens/1 or /mensagens/1.json
  def destroy
    REDIS_CLIENT.del(@key)
    respond_to do |format|
      format.html { redirect_to mensagens_path, notice: "Mensagem foi apagada com sucesso" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mensagem
      @key = params[:id]
      @mensagem = { "#{@key}": REDIS_CLIENT.get(@key) }
    end
end
