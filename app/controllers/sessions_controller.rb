class SessionsController < ApplicationController
  def destroy
    session.clear
    redirect_to root_path
  end

  def create
    session.clear
    if request.env['omniauth.auth'].present?
      @input_email = request.env['omniauth.auth'][:info][:email]
      @student_distribution = StudentDistribution.find_by(email: @input_email)
      @person = Person.find_by(email: @input_email)
      case true
      when @input_email == Rails.application.credentials.editor_email
        session[:user] = "editor"
        @current_user = Rails.application.credentials.editor_fullname
      when @student_distribution.present?
        session[:user] = "student"
        @current_user = "#{@student_distribution.student.full_name} (група #{@student_distribution.group.group})"
      when @person.present?
        @teacher_distribution = TeacherDistribution.find_by(person_id: @person.id)
        if @teacher_distribution.present?
          session[:user] = "teacher"
          @current_user = "#{@person.full_name} (#{@teacher_distribution.unit.name})"
        end
      else
        session[:user] = "outsider"
        @current_user = "сторонній"
      end
    end
  end

  def surveys_save
    if session[:user] == "student"
      params[:student_distribution][:survey].each do |id, rate|
        Survey.find(id).update(rating: rate[:rating].to_i)
      end
      
    end
  end
end