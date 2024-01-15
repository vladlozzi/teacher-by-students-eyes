class StudentDistributionsController < ApplicationController
  before_action :set_editor
  before_action :set_student_distribution, only: %i[ show edit update destroy ]
  before_action :set_options_for_select, only: %i[ new edit create update ]

  # GET /student_distributions or /student_distributions.json
  def index
    @student_distributions = StudentDistribution.all
  end

  # GET /student_distributions/1 or /student_distributions/1.json
  def show; end

  # GET /student_distributions/new
  def new
    @student_distribution = StudentDistribution.new
  end

  # GET /student_distributions/1/edit
  def edit; end

  # POST /student_distributions or /student_distributions.json
  def create
    @student_distribution = StudentDistribution.new(student_distribution_params)

    respond_to do |format|
      if @student_distribution.save
        format.html { redirect_to student_distribution_url(@student_distribution), notice: "Позицію розподілу успішно створено." }
        format.json { render :show, status: :created, location: @student_distribution }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student_distribution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /student_distributions/1 or /student_distributions/1.json
  def update
    respond_to do |format|
      if @student_distribution.update(student_distribution_params)
        format.html { redirect_to student_distribution_url(@student_distribution), notice: "Позицію розподілу успішно змінено." }
        format.json { render :show, status: :ok, location: @student_distribution }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student_distribution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /student_distributions/1 or /student_distributions/1.json
  def destroy
    @student_distribution.destroy

    respond_to do |format|
      format.html { redirect_to student_distributions_url, notice: "Позицію розподілу успішно видалено." }
      format.json { head :no_content }
    end
  end

  def new_import
  end

  def import
    if params[:txt_file].present?
      distribution_count = 0
      StudentDistribution.truncate
      import_errors = []
      File.foreach(params[:txt_file].path).with_index(1) do |line, index|
        full_name, edebo_person_code, group_name, edebo_study_code, email =
          line.delete("\r").delete("\n").split(";")
        edebo_person_code = "" if edebo_person_code.nil?
        group_name = "" if group_name.nil?
        edebo_study_code = "" if edebo_study_code.nil?
        student = Student.find_by(edebo_person_code: edebo_person_code)
        group = Group.find_by(group: group_name)
        last_name, first_name = student.full_name.split(' ')
        email = first_name.strip.emailize + '.' +
          last_name.strip.emailize + '-' +
          group_name.gsub("-", "").strip.emailize + '@' +
          ENV["email_domain"].strip
        distribution  = StudentDistribution.create(
          student: student, group: group, edebo_study_code: edebo_study_code, email: email
        )
        if distribution.valid?
          distribution_count += 1
        else
          import_errors << "Рядок #{index}: " + distribution.errors.map{ |e|
            "#{e.full_message} [#{first_name}; #{last_name}; #{group_name}; #{email}]"
          }.join(" ")
        end
      end
      notice = "З файлу #{params[:txt_file].original_filename} " +
        "імпортовано дані про #{distribution_count} " + (
        distribution_count % 10 == 1 && distribution_count % 100 != 11 ? "позицію розподілу" : "позицій розподілу"
      ) + "." +
        (import_errors.empty? ? "" : "<br>Виправте помилки у рядках файлу і повторіть імпорт.<br>" + import_errors.join("<br>"))
      redirect_to student_distributions_path, notice: notice[0..1015] + (notice[1016].nil? ? "" : "<br>, , ,")
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student_distribution
      @student_distribution = StudentDistribution.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_distribution_params
      params.require(:student_distribution).permit(:student_id, :group_id, :edebo_study_code, :email)
    end

    def set_options_for_select
      @students_for_select = Student.pluck(:full_name, :id)
      @groups_for_select = Group.pluck(:group, :id)
    end

end