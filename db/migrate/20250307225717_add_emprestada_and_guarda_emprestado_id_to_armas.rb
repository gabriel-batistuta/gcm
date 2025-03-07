class AddEmprestadaAndGuardaEmprestadoIdToArmas < ActiveRecord::Migration[8.0]
  def change
    unless column_exists?(:armas, :emprestada)
      add_column :armas, :emprestada, :boolean, default: false, null: false
    end

    unless column_exists?(:armas, :guarda_emprestado_id)
      add_column :armas, :guarda_emprestado_id, :integer
    end
  end
end
