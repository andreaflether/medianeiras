class Admin::PeopleController < AdminController
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  # GET /people
  # GET /people.json
  def index
    @people = Person.all
  end

  # GET /people/1
  # GET /people/1.json
  def show

  end

  # GET /people/new
  def new
    @type = params[:type]
    @person = Person.new
    case @type
    when 'student'
      @person.build_student
    when 'volunteer'
      @person.build_volunteer
    end
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save
        # puts params[:person].has_key?(:student_attributes)
        format.html do
          redirect_to @person, notice: "Cadastro efetuado com sucesso!" if person_params.has_key?(:student_attributes) && person_params.has_key?(:volunteer_attributes) && 
          redirect_to @person.student, type: 'student', notice: 'Cadastro efetuado com sucesso!' if person_params.has_key?(:student_attributes)
          redirect_to @person.volunteer, type: 'volunteer', notice: 'Cadastro efetuado com sucesso!' if person_params.has_key?(:volunteer_attributes)
        end
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: 'Person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def person_params
      params.require(:person).permit(:name, :birthday, :address, :neighborhood, :religion, :rg, :start_date, :exit_date,
                                     student_attributes: [:current_grade, :school], # Nested Attributes: Alunos
                                     volunteer_attributes: [:email, :speciality, :cpf] # Nested Attributes: Voluntários
      )
    end
end
