# frozen_string_literal: true

# DepartmentsController
class DepartmentsController < ApplicationController
  before_action :authenticate_user!

  def index
    grid = DepartmentsGrid.new(params[:departments_grid]) do |scope|
      scope.page(params[:page]).per_page(5)
    end

    render :index, locals: { departments_grid: grid }
  end

  def new
    form = DepartmentForm.new(Department.new)
    form.prepopulate!
    render :new, locals: { form: form }
  end

  def create
    form = DepartmentForm.new(Department.new)
    form.call(params[:departments]) do
      flash[:success] = 'Запись успешно добавлена!'
      return redirect_to edit_department_path(form.model.id)
    end

    flash[:error] = 'Не все обязательные поля заполнены!'
    form.prepopulate!
    render :new, locals: { form: form }
  end

  def edit
    form = DepartmentForm.new(department)
    form.prepopulate!
    render :edit, locals: { form: form }
  end

  def update
    form = DepartmentForm.new(department)
    form.call(params[:departments]) do
      flash[:success] = 'Запись успешно обновлена!'
      return redirect_to edit_department_path(form.model.id)
    end

    flash[:error] = 'Не все обязательные поля заполнены!'
    form.prepopulate!
    render :edit, locals: { form: form }
  end

  def destroy
    if department.present?
      department.destroy!
      flash[:success] = 'Запись успешно удалена!'
    else
      flash[:error] = 'Запись не найдена!'
    end
    redirect_to departments_path
  end

  private

  def department
    @department ||= Department.find(params[:id])
  end
end
