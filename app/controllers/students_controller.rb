class StudentsController < ApplicationController

  def index
    matching_students = Student.all
    @list_of_students = matching_students.order({ :created_at => :desc })

    render({ :template => "students/index" })
  end

  def show
    the_id = params.fetch("path_id")
    matching_students = Student.where({:id => the_id })
    @the_student = matching_students.at(0)

    render({ :template => "students/show" })
  end

  def create
    @the_student = Student.new
    @the_student.first_name = params[:query_first_name]
    @the_student.last_name = params.fetch("query_last_name")
    @the_student.email = params.fetch("query_email")

    if @the_student.valid?
      @the_student.save
      redirect_to("/students", { :notice => "Student created successfully." })
    else
      redirect_to("/students", { :notice => "Student failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    @student = Student.where({ :id => the_id }).at(0)

    @student.first_name = params.fetch("query_first_name")
    @student.last_name = params.fetch("query_last_name")
    @student.email = params.fetch("query_email")

    if @student.valid?
      @student.save
      redirect_to("/students/#{@student.id}", { :notice => "Student updated successfully."} )
    else
      redirect_to("/students/#{@student.id}", { :alert => "Student failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @student = Student.where({ :id => the_id }).at(0)

    @student.destroy

    redirect_to("/students", { :notice => "Student deleted successfully."} )
  end
end
