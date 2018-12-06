class AddAasmStateToRoutes < ActiveRecord::Migration[5.2]
  def change
    add_column :routes, :aasm_state, :string
  end
end
