class StudentsController < ApplicationController
  before_action :set_editor
  before_action :set_student, only: %i[ show edit update destroy ]

  # GET /students or /students.json
  def index
    @students = Student.order(:full_name)
  end

  # GET /students/1 or /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students or /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to student_url(@student), notice: "Новий запис успішно створено." }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to student_url(@student), notice: "Дані про студента/студентку успішно збережено." }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    @student.destroy

    respond_to do |format|
      format.html { redirect_to students_url, notice: "Дані успішно видалено." }
      format.json { head :no_content }
    end
  end

  def new_import
  end

  def import
    if params[:txt_file].present?
      students_count = 0
      Student.truncate
      import_errors = []
      File.foreach(params[:txt_file].path).with_index(1) do |line, index|
        full_name, edebo_person_code =
          line.delete("\r").delete("\n").split(";")
        full_name = "" if full_name.nil?
        edebo_person_code = "" if edebo_person_code.nil?
        student = Student.create(
          full_name: full_name.strip, edebo_person_code: edebo_person_code.strip
        )
        if student.valid?
          students_count += 1
        else
          import_errors << "Рядок #{index}: " + student.errors.map{ |e| e.full_message }.join(" ")
        end
      end
      notice = "З файлу #{params[:txt_file].original_filename} " +
        "імпортовано дані про #{students_count} " + (
        students_count % 10 == 1 && students_count % 100 != 11 ? "студента/студентку" : "студентів/студенток"
      ) + "." +
        (import_errors.empty? ? "" : "<br>Виправте помилки у рядках файлу і повторіть імпорт.<br>" + import_errors.join("<br>"))
      redirect_to students_path, notice: notice[0..1015] + (notice[1016].nil? ? "" : "<br>, , ,")
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:full_name, :edebo_person_code)
    end
end
