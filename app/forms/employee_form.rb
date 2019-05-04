# frozen_string_literal: true
class EmployeeForm < BaseForm
  include Reform::Form::ActiveModel::ModelReflections

  model :employees

  property :name
  property :active
  property :department_id
  validates :name, presence: true
  validates :active, presence: true
  validates :department_id, presence: true
end
