class CoursesController < ApplicationController
  before_action :check_course_exists, only: [:show, :destroy, :update]
  
  def index
    courses=Course.all
    render json: courses
  end
  
  def show
    render json: @course 
  end
  
  def create
    course=Course.new(course_param)
    if course.save
        render json: course
    else
        render json: {errors: "Unsuccessfull to add course in course"}
    end
  end
  
  def update
    @course.update(course_param)
    render json: @course
  end
  
  def destroy
    @course.destroy
    render json: @course
  end
  
  def course_param
    params.permit(:course_name,:college_id)
  end
  
  def check_course_exists
    begin
      @course=Course.find(params[:id])
    rescue
      render json: "Course not found"
    end
  end
end

