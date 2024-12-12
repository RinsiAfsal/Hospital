class Receptionist::PatientsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_receptionist
  before_action :set_patient, only: [:edit, :update, :destroy, :show]

  def index
    @patients = Patient.all
  end

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      redirect_to receptionist_patients_path, notice: "Patient was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @patient
  end

  def edit
    @patient
  end

  def update
    if @patient.update(patient_params)
      redirect_to receptionist_patients_path, notice: "Patient was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @patient.destroy
    redirect_to receptionist_patients_path, alert: "Patient was successfully deleted."
  end

  private

  def set_patient
    @patient = Patient.find_by(id: params[:id])
  end

  def check_receptionist
    redirect_to root_path, alert: "Access Denied" unless current_user.receptionist?
  end

  def patient_params
    params.require(:patient).permit(:first_name, :last_name, :dob, :email, :phone)
  end
end