Hanami::Model.migration do
  change do
    create_table :comments do
      primary_key :id

      column :text, String
      column :attachment_data, String

      foreign_key :task_id, :tasks, on_delete: :cascade, null: false
      index :task_id

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
