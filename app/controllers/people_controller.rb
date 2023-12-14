class PeopleController < ApplicationController
  before_action :set_person, only: %i[ show edit update destroy ]

  # GET /people or /people.json
  def index
    @people = Person.order(:full_name)
  end

  # GET /people/1 or /people/1.json
  def show; end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit; end

  # POST /people or /people.json
  def create
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to person_url(@person), notice: "Запис про нову особу успішно створено." }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1 or /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to person_url(@person), notice: "Дані про особу успішно збережено." }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1 or /people/1.json
  def destroy
    @person.destroy

    respond_to do |format|
      format.html { redirect_to people_url, notice: "Дані про особу успішно видалено." }
      format.json { head :no_content }
    end
  end

  def new_import
  end

  def import
    if params[:txt_file].present?
      people_count = 0
      Person.truncate
      import_errors = []
      File.foreach(params[:txt_file].path).with_index(1) do |line, index|
        full_name, email, orcid, scopus_authorid, wos_researcherid =
          line.delete("\r").delete("\n").split(";")
        full_name = "" if full_name.nil?    def set_options_for_select
      @students_for_select = Student.pluck(:full_name, :id)
      @groups_for_select = Group.pluck(:group, :id)
    end

        email = "" if email.nil?
        orcid = "" if orcid.nil?
        scopus_authorid = ""  if scopus_authorid.nil?
        wos_researcherid = "" if wos_researcherid.nil?
        person = Person.create(
          full_name: full_name.strip, email: email.strip, orcid: orcid.strip,
            scopus_authorid: scopus_authorid.strip, wos_researcherid: wos_researcherid.strip
        )
        if person.valid?
          people_count += 1
        else
          import_errors << "Рядок #{index}: " + person.errors.map{ |e| e.full_message }.join(" ")
        end
      end
      notice = "З файлу #{params[:txt_file].original_filename} " +
        "імпортовано дані про #{people_count} " + (
        people_count % 10 == 1 && people_count % 100 != 11 ? "особу" : "осіб"
      ) + "." +
        (import_errors.empty? ? "" : "<br>Виправте помилки у рядках файлу і повторіть імпорт.<br>" + import_errors.join("<br>"))
      redirect_to people_path, notice: notice[0..1015] + (notice[1016].nil? ? "" : "<br>, , ,")
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def person_params
      params.require(:person).permit(:full_name, :email, :orcid, :scopus_authorid, :wos_researcherid)
    end
end
