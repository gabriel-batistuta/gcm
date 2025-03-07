class Movimentacao < ApplicationRecord
  belongs_to :arma
  belongs_to :guarda

  validate :arma_disponivel_para_emprestimo, if: -> { tipo == "emprestimo" }
  validate :arma_valida_para_devolucao, if: -> { tipo == "devolucao" }

  private

  def arma_disponivel_para_emprestimo
    if arma.emprestada?
      errors.add(:arma, "já está emprestada a outro guarda.")
    end
  end

  def arma_valida_para_devolucao
    if !arma.emprestada? || arma.guarda_emprestado_id != guarda_id
      errors.add(:arma, "não pode ser devolvida, dados inconsistentes.")
    end
  end
end
