class Null < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :nickname, null: false
    end

    create_table :posts do |t|
      t.string :title, null: false
      t.string :body, null: false
      t.datetime :published_at, default: -> { 'CURRENT_TIMESTAMP' }
    end

    add_reference :posts, :author, references: :users, index: true
    add_foreign_key :posts, :users, column: :author_id

    create_table :comments do |t|
      t.string :body, null: false
      t.references :post, null: false, index: true, foreign_key: true
      t.datetime :published_at, default: -> { 'CURRENT_TIMESTAMP' }
    end

    add_reference :comments, :author, references: :users, index: true
    add_foreign_key :comments, :users, column: :author_id

    change_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      # Uncomment below if timestamps were not included in your original model.
      # t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true

  end
end
