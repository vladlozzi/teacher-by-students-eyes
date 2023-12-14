class GroupsController < ApplicationController
  before_action :set_group, only: %i[ show edit update destroy ]

  # GET /groups or /groups.json
  def index
    @groups = Group.order(:group)
  end

  # GET /groups/1 or /groups/1.json
  def show
    @students = StudentDistribution.where(group: @group).includes(:student).order("students.full_name")
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups or /groups.json
  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to group_url(@group), notice: "Запис про академгрупу успішно створено." }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to group_url(@group), notice: "Дані про академгрупу успішно змінено." }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url, notice: "Дані про академгрупу успішно видалено." }
      format.json { head :no_content }
    end
  end

  def new_import
  end

  def import
    if params[:txt_file].present?
      groups_count = 0
      Group.truncate
      import_errors = []
      File.foreach(params[:txt_file].path).with_index(1) do |line, index|
        group_name = line.delete("\r").delete("\n").split(";")
        group_name = [""] if group_name.first.nil?
        group = Group.create( group: group_name.first.strip )
        if group.valid?
          groups_count += 1
        else
          import_errors << "Рядок #{index}: " + group.errors.map{ |e| e.full_message }.join(" ")
        end
      end
      notice = "З файлу #{params[:txt_file].original_filename} " +
        "імпортовано дані про #{groups_count} " + (
          groups_count % 10 == 1 && groups_count % 100 != 11 ? "академгрупу" : "академгруп"
        ) + "." +
        (import_errors.empty? ? "" : "<br>Виправте помилки у рядках файлу і повторіть імпорт.<br>" + import_errors.join("<br>"))
      redirect_to groups_path, notice: notice[0..1015] + (notice[1016].nil? ? "" : "<br>, , ,")
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def group_params
      params.require(:group).permit(:group)
    end
end
