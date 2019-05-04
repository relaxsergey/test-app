# frozen_string_literal: true
class DepartmentForm < BaseForm
  include Reform::Form::ActiveModel::ModelReflections

  model :departments

  property :title
  validates :title, presence: true
end
