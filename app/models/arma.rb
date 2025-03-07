class Arma < ApplicationRecord
    belongs_to :guarda_emprestado, class_name: "Guarda", optional: true
  
    def emprestar!(guarda)
      Rails.logger.info "Atualizando status de empréstimo da arma #{id} para o guarda #{guarda.id}"
      update!(emprestada: true, guarda_emprestado_id: guarda.id)
    rescue => e
      Rails.logger.error "Erro ao emprestar arma #{id}: #{e.message}"
    end
  
    def devolver!
      Rails.logger.info "Devolvendo arma #{id}, removendo guarda emprestado"
      update!(emprestada: false, guarda_emprestado_id: nil)
    rescue => e
      Rails.logger.error "Erro ao devolver arma #{id}: #{e.message}"
    end
  end
  