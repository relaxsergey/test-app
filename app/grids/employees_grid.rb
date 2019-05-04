# frozen_string_literal: true
class EmployeesGrid
  include Datagrid

  scope do
    Employee.order(created_at: :desc)
  end

  filter(:name, :string,
         header: 'Search',
         class: 'search_label') { |value| where("employees.name LIKE ?", "#{value}%") }
  filter(:department, :enum,
         select: Department.pluck(:title, :id))
  filter(:active, :enum,
         select: [true, false])

  column(:name, class: 'col-sm-2', html: true, order: true) do |record|
    link_to record.name, edit_employee_path(record)
  end

  column(:active, class: 'col-sm-2', html: true, order: true) do |record|
    record.active
  end

  column(:department, class: 'col-sm-2', html: true, order: true) do |record|
    record.department.title
  end

  column(:actions, header: '', html: true, order: false, class: 'col-sm-1') do |record|
    render 'employees/grid_actions', employee: record
  end
end
