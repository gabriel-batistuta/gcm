class Guarda < ApplicationRecord
  # Associa as armas emprestadas a esse guarda
  belongs_to :equipe
  has_many :armas_emprestadas, class_name: "Arma", foreign_key: "guarda_emprestado_id"
  # Antes de destruir o guarda, devolve as armas associadas
  before_destroy :devolver_armas

  private

  def devolver_armas
    armas_emprestadas.find_each do |arma|
      Rails.logger.info "Devolvendo arma #{arma.id} antes de destruir guarda #{id}"
      arma.update_columns(emprestada: false, guarda_emprestado_id: nil)
    end
  end
end
