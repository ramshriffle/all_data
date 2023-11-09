class UsersController < ApplicationController
  before_action :check_user_exists, only: [:show, :destroy, :update]
  
  def index
    @user=User.all
    render json: @user
  end
  
  def show
    render json: @user 
  end
  
  def create
    user=User.new(param_user)
    if user.save
      render json: user
    else
      render json: {errors: "Failed to create new user"}
    end
  end
  
  def update
    @user.update(param_user)
    render json: @user
  end
  
  def destroy
    @user.destroy
    render json: @user
  end
  
  def param_user
    params.permit(:first_name,:last_name,:email,:college_id,:course_id)
  end
  
  def check_user_exists
    begin
      @user=User.find(params[:id])
    rescue
      render json: "User not found"
    end
  end

  def show_all_users_by_courses
    users = User.includes(:course).all
    users_by_course = users.group_by{|student| student.course.course_name}
    render json: users_by_course
  end

  def show_all_users_of_specific_course
    all_users=User.includes(:course).where(course: {course_name: params[:course_name]})
    render json: all_users
  end

  def current_user_course
    user=User.find(params[:user_id])
    user_course=user.course
    render json: user_course
  end
end
