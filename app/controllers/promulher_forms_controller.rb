# frozen_string_literal: true

class PromulherFormsController < ApplicationController
  before_action :set_promulher_form, only: %i[show edit update destroy]

  # GET /promulher_forms
  # GET /promulher_forms.json
  def index
    @promulher_forms = PromulherForm.all
  end

  # GET /promulher_forms/1
  # GET /promulher_forms/1.json
  def show; end

  # GET /promulher_forms/new
  def new
    @promulher_form = PromulherForm.new
  end

  # GET /promulher_forms/1/edit
  def edit; end

  # POST /promulher_forms
  # POST /promulher_forms.json
  def create
    @promulher_form = PromulherForm.new(promulher_form_params)

    respond_to do |format|
      if @promulher_form.save
        format.html { redirect_to @promulher_form, notice: 'Promulher form was successfully created.' }
        format.json { render :show, status: :created, location: @promulher_form }
      else
        format.html { render :new }
        format.json { render json: @promulher_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /promulher_forms/1
  # PATCH/PUT /promulher_forms/1.json
  def update
    respond_to do |format|
      if @promulher_form.update(promulher_form_params)
        format.html { redirect_to @promulher_form, notice: 'Promulher form was successfully updated.' }
        format.json { render :show, status: :ok, location: @promulher_form }
      else
        format.html { render :edit }
        format.json { render json: @promulher_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /promulher_forms/1
  # DELETE /promulher_forms/1.json
  def destroy
    @promulher_form.destroy
    respond_to do |format|
      format.html { redirect_to promulher_forms_url, notice: 'Promulher form was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_promulher_form
    @promulher_form = PromulherForm.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def promulher_form_params
    params.require(:promulher_form).permit(:family_size, :f_children, :m_children, :works)
  end
end
