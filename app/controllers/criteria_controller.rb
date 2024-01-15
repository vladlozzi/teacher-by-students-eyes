class CriteriaController < ApplicationController
  before_action :set_editor
  before_action :set_criterium, only: %i[ show edit update destroy ]

  # GET /criteria or /criteria.json
  def index
    @criteria = Criterium.order(:id)
  end

  # GET /criteria/1 or /criteria/1.json
  def show
  end

  # GET /criteria/new
  def new
    @criterium = Criterium.new
  end

  # GET /criteria/1/edit
  def edit
  end

  # POST /criteria or /criteria.json
  def create
    @criterium = Criterium.new(criterium_params)

    respond_to do |format|
      if @criterium.save
        format.html { redirect_to criterium_url(@criterium), notice: "Запис про критерій успішно створено." }
        format.json { render :show, status: :created, location: @criterium }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @criterium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /criteria/1 or /criteria/1.json
  def update
    respond_to do |format|
      if @criterium.update(criterium_params)
        format.html { redirect_to criterium_url(@criterium), notice: "Дані про критерій успішно змінено." }
        format.json { render :show, status: :ok, location: @criterium }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @criterium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /criteria/1 or /criteria/1.json
  def destroy
    @criterium.destroy

    respond_to do |format|
      format.html { redirect_to criteria_url, notice: "Дані про критерій успішно видалено." }
      format.json { head :no_content }
    end
  end

  def new_import
  end

  def import
    if params[:txt_file].present?
      criteria_count = 0
      Criterium.truncate
      import_errors = []
      File.foreach(params[:txt_file].path).with_index(1) do |line, index|
        name, scale =
          line.delete("\r").delete("\n").split(";")
        name = "" if name.nil?
        scale = "" if scale.nil?
        criterium = Criterium.create(name: name.strip, scale: scale.strip)
        if criterium.valid?
          criteria_count += 1
        else
          import_errors << "Рядок #{index}: " + criterium.errors.map{ |e| e.full_message }.join(" ")
        end
      end
      notice = "З файлу #{params[:txt_file].original_filename} " +
        "імпортовано дані про #{criteria_count} " + (
        criteria_count % 10 == 1 && criteria_count % 100 != 11 ? "критерій" : "критеріїв"
      ) + "." +
        (import_errors.empty? ? "" : "<br>Виправте помилки у рядках файлу і повторіть імпорт.<br>" + import_errors.join("<br>"))
      redirect_to criteria_path, notice: notice[0..1015] + (notice[1016].nil? ? "" : "<br>, , ,")
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_criterium
      @criterium = Criterium.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def criterium_params
      params.require(:criterium).permit(:name, :scale)
    end
end
