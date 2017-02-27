class DateTimeValidator < ActiveModel::EachValidator
  def validate_each(record, attr_name, value)
    if ((DateTime.parse(value) rescue ArgumentError) == ArgumentError)
      record.errors.add(attr_name, :invalid)
    end
  end
end