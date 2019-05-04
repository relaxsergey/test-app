# frozen_string_literal: true

# EmployeesController
class EmployeesController < ApplicationController
  before_action :authenticate_user!

  def index
    grid = EmployeesGrid.new(params[:employees_grid]) do |scope|
      scope.page(params[:page]).per_page(5)
    end

    render :index, locals: { employees_grid: grid }
  end

  def new
    form = EmployeeForm.new(Employee.new)
    form.prepopulate!
    render :new, locals: { form: form }
  end

  def create
    form = EmployeeForm.new(Employee.new)
    form.call(params[:employees]) do
      flash[:success] = 'Запись успешно добавлена!'
      return redirect_to edit_employee_path(form.model.id)
    end

    flash[:error] = 'Не все обязательные поля заполнены!'
    form.prepopulate!
    render :new, locals: { form: form }
  end

  def edit
    form = EmployeeForm.new(employee)
    form.prepopulate!
    render :edit, locals: { form: form }
  end

  def update
    form = EmployeeForm.new(employee)
    form.call(params[:employees]) do
      flash[:success] = 'Запись успешно обновлена!'
      return redirect_to edit_employee_path(form.model.id)
    end

    flash[:error] = 'Не все обязательные поля заполнены!'
    form.prepopulate!
    render :edit, locals: { form: form }
  end

  def destroy
    if employee.present?
      employee.destroy!
      flash[:success] = 'Запись успешно удалена!'
    else
      flash[:error] = 'Запись не найдена!'
    end
    redirect_to employees_path
  end

  private

  def employee
    @employee ||= Employee.find(params[:id])
  end
end
