Hanami::Model.migration do
  change do
    create_table :tasks do
      primary_key :id

      column :title, String, null: false
      column :done, TrueClass, default: false, null: false
      column :position, Integer, null: false
      column :deadline, DateTime

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      foreign_key :project_id, :projects, on_delete: :cascade, null: false
      index :project_id

      index :position
    end
  end
end
