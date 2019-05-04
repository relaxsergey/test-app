# frozen_string_literal: true
class DepartmentsGrid
  include Datagrid

  scope do
    Department.order(created_at: :desc)
  end

  filter(:title, :string,
         header: 'Search',
         class: 'search_label') { |value| where("departments.title LIKE ?", "#{value}%") }

  column(:title, class: 'col-sm-6', html: true, order: true) do |record|
    link_to record.title, edit_department_path(record)
  end

  column(:actions, header: '', html: true, order: false, class: 'col-sm-2') do |record|
    render 'departments/grid_actions', department: record
  end
end
