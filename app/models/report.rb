# Tableless model for validation

class Report
  include ActiveModel::Validations
  extend ActiveModel::Naming

  attr_accessor :start_date, :end_date, :email

  validates :start_date, :end_date, :email, presence: true
  validates :email, email: true
  validates :start_date, :end_date, date_time: true

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
end
