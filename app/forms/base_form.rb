# frozen_string_literal: true
class BaseForm < Reform::Form
  include Reform::Form::ActiveModel::ModelReflections

  def call(params)
    return unless validate(params)

    sync
    save
    yield(model) if block_given?
  end

  def new_record?
    model.persisted?
  end
end
