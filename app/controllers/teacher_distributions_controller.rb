class TeacherDistributionsController < ApplicationController
  before_action :set_teacher_distribution, only: %i[ show edit update destroy ]
  before_action :set_options_for_select, only: %i[ new edit create update ]

  # GET /teacher_distributions or /teacher_distributions.json
  def index
    @teacher_distributions =
      TeacherDistribution.
        includes(:unit).
        includes(:person).
        order("units.name, people.full_name")
  end

  # GET /teacher_distributions/1 or /teacher_distributions/1.json
  def show; end

  # GET /teacher_distributions/new
  def new
    @teacher_distribution = TeacherDistribution.new
  end

  # GET /teacher_distributions/1/edit
  def edit; end

  # POST /teacher_distributions or /teacher_distributions.json
  def create
    @teacher_distribution = TeacherDistribution.new(teacher_distribution_params)

    respond_to do |format|
      if @teacher_distribution.save
        format.html { redirect_to teacher_distribution_url(@teacher_distribution), notice: "Позицію розподілу успішно створено." }
        format.json { render :show, status: :created, location: @teacher_distribution }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @teacher_distribution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teacher_distributions/1 or /teacher_distributions/1.json
  def update
    respond_to do |format|
      if @teacher_distribution.update(teacher_distribution_params)
        format.html { redirect_to teacher_distribution_url(@teacher_distribution), notice: "Позицію розподілу успішно змінено." }
        format.json { render :show, status: :ok, location: @teacher_distribution }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @teacher_distribution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teacher_distributions/1 or /teacher_distributions/1.json
  def destroy
    @teacher_distribution.destroy

    respond_to do |format|
      format.html { redirect_to teacher_distributions_url, notice: "Позицію розподілу успішно видалено." }
      format.json { head :no_content }
    end
  end

  def new_import
  end

  def import
    if params[:txt_file].present?
      distribution_count = 0
      TeacherDistribution.truncate
      import_errors = []
      File.foreach(params[:txt_file].path).with_index(1) do |line, index|
        unit_name, full_name = line.delete("\r").delete("\n").split(";")
        person = Person.find_by(full_name: full_name)
        unit = Unit.find_by(name: unit_name)
        distribution  = TeacherDistribution.create(person: person, unit: unit)
        if distribution.valid?
          distribution_count += 1
        else
          import_errors << "Рядок #{index}: " + distribution.errors.map{ |e|
            "#{e.full_message} [#{full_name}; #{unit_name}]"
          }.join(" ")
        end
      end
      notice = "З файлу #{params[:txt_file].original_filename} " +
        "імпортовано дані про #{distribution_count} " + (
        distribution_count % 10 == 1 && distribution_count % 100 != 11 ? "позицію розподілу" : "позицій розподілу"
      ) + "." +
        (import_errors.empty? ? "" : "<br>Виправте помилки у рядках файлу і повторіть імпорт.<br>" + import_errors.join("<br>"))
      redirect_to teacher_distributions_path, notice: notice[0..1015] + (notice[1016].nil? ? "" : "<br>, , ,")
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teacher_distribution
      @teacher_distribution = TeacherDistribution.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def teacher_distribution_params
      params.require(:teacher_distribution).permit(:unit_id, :person_id)
    end

    def set_options_for_select
      @persons_for_select = Person.pluck(:full_name, :id)
      @units_for_select = Unit.pluck(:name, :id)
    end

end