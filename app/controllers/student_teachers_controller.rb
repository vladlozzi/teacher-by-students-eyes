class StudentTeachersController < ApplicationController
  before_action :set_editor
  before_action :set_student_teacher, only: %i[ show edit update destroy ]
  before_action :set_options_for_select, only: %i[ new edit create update ]

  # GET /student_teachers or /student_teachers.json
  def index
    @student_teachers = StudentTeacher.all
  end

  # GET /student_teachers/1 or /student_teachers/1.json
  def show; end

  # GET /student_teachers/new
  def new
    @student_teacher = StudentTeacher.new
  end

  # GET /student_teachers/1/edit
  def edit; end

  # POST /student_teachers or /student_teachers.json
  def create
    @student_teacher = StudentTeacher.new(student_teacher_params)

    respond_to do |format|
      if @student_teacher.save
        format.html { redirect_to student_teacher_url(@student_teacher), notice: "Пару успішно створено." }
        format.json { render :show, status: :created, location: @student_teacher }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student_teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /student_teachers/1 or /student_teachers/1.json
  def update
    respond_to do |format|
      if @student_teacher.update(student_teacher_params)
        format.html { redirect_to student_teacher_url(@student_teacher), notice: "Пару успішно змінено." }
        format.json { render :show, status: :ok, location: @student_teacher }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student_teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /student_teachers/1 or /student_teachers/1.json
  def destroy
    @student_teacher.destroy

    respond_to do |format|
      format.html { redirect_to student_teachers_url, notice: "Пару успішно видалено." }
      format.json { head :no_content }
    end
  end

  def new_import
  end

  def import
    if params[:txt_file].present?
      pairs_count = 0
      StudentTeacher.truncate
      import_errors = []
      File.foreach(params[:txt_file].path).with_index(1) do |line, index|
        student_full_name, edebo_study_code, group_name, teacher_full_name, unit_name =
          line.delete("\r").delete("\n").split(";")
        student_full_name = "" if student_full_name.nil?
        edebo_study_code = "" if edebo_study_code.nil?
        group_name = "" if group_name.nil?
        teacher_full_name = "" if teacher_full_name.nil?
        unit_name = "" if unit_name.nil?
        edebo_study_code.strip!; group_name.strip!; teacher_full_name.strip!; unit_name.strip!
        if edebo_study_code.empty? || group_name.empty? || teacher_full_name.empty? || unit_name.empty?
          import_errors << "Рядок #{index} містить одне або декілька порожніх полів."
        else
          student_distribution = StudentDistribution.find_by(edebo_study_code: edebo_study_code)
          person = Person.find_by(full_name: teacher_full_name)
          unit = Unit.find_by(name: unit_name)
          if student_distribution.nil?
            import_errors << "Рядок #{index} містить помилку в коді навчання ЄДЕБО: #{edebo_study_code}."
          else
            student_distribution_id = student_distribution.id
          end
          if person.nil?
            import_errors << "Рядок #{index} містить помилку в ПІБ персоналу; #{teacher_full_name}."
          else
            person_id = person.id
          end
          if unit.nil?
            import_errors << "Рядок #{index} містить помилку в назві кафедри: #{unit_name}."
          else
            unit_id = unit.id
          end
          unless student_distribution.nil? || person.nil? || unit.nil?
            teacher_distribution = TeacherDistribution.find_by(
              person_id: person_id, unit_id: unit_id
            )
            if teacher_distribution.nil?
              import_errors << "Рядок #{index}: особу #{teacher_full_name} не знайдено на кафедрі #{unit_name}."
            else
              student_teacher = StudentTeacher.create(
                student_distribution_id: student_distribution_id,
                teacher_distribution_id: teacher_distribution.id
              )
              if student_teacher.valid?
                pairs_count += 1
              else
                import_errors << "Рядок #{index}: " + student_teacher.errors.map{ |e|
                  "#{e.full_message} [#{student_full_name}; #{edebo_study_code}; #{group_name}; #{teacher_full_name}; #{unit_name}]"
                }.join(" ")
              end
            end
          end
        end
      end
      notice = "З файлу #{params[:txt_file].original_filename} " +
        "імпортовано дані про #{pairs_count} " + (
        pairs_count % 10 == 1 && pairs_count % 100 != 11 ? "позицію розподілу" : "позицій розподілу"
      ) + "." +
        (import_errors.empty? ? "" : "<br>Виправте помилки у рядках файлу і повторіть імпорт.<br>" + import_errors.join("<br>"))
      redirect_to student_teachers_path, notice: notice[0..1015] + (notice[1016].nil? ? "" : "<br>, , ,")
    end
  end

  def create_survey
    Survey.truncate
    StudentTeacher.all.pluck(:id).each do |student_teacher_id|
      Criterium.all.pluck(:id).each do |criterium_id|
        Survey.create(student_teacher_id: student_teacher_id, criterium_id: criterium_id)
      end
    end
    redirect_to student_teachers_path, notice: "Опитування успішно створено. Кількість позицій: #{Survey.count}."
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_student_teacher
      @student_teacher = StudentTeacher.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_teacher_params
      params.require(:student_teacher).permit(:student_distribution_id, :teacher_distribution_id)
    end

    def set_options_for_select
      @student_distributions_for_select =
        StudentDistribution.includes(:group).includes(:student).
          order("students.full_name, groups.group").
          pluck("students.full_name, groups.group, student_distributions.id").
          map{ |full_name, group, id| [full_name + " | " + group, id] }
      @teacher_distributions_for_select =
        TeacherDistribution.includes(:unit).includes(:person).
          order("people.full_name, units.name").
          pluck("people.full_name, units.name, teacher_distributions.id").
          map{ |full_name, unit_name, id| [full_name + " | " + unit_name, id] }
    end
end
