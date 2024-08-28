class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authorize_admin, only: [:index, :destroy]
  before_action :authorize_executive, only: [:create_employee]
  skip_before_action :authenticate_user!, only: [:create]

  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)
    @user.role = 'executive'  # Asumimos que este endpoint es solo para ejecutivos

    if @user.save
      @user.create_executive_profile(executive_profile_params)
      # No enviamos el token JWT aquí, ya que la cuenta aún no está confirmada
      render json: { message: 'Por favor, confirma tu cuenta a través del enlace enviado a tu correo electrónico.' }, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def create_employee
    @company = current_user.executive_profile.companies.find(params[:company_id])
    @user = User.new(user_params.merge(role: 'employee'))

    if @user.save
      @employee_profile = @user.create_employee_profile(employee_profile_params.merge(company: @company))
      @employee_profile.create_personal_info(personal_info_params)
      @employee_profile.create_work_info(work_info_params)
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :role)
  end

  def create_profile(user)
    case user.role
    when 'admin'
      user.create_admin_profile
    when 'executive'
      user.create_executive_profile(executive_profile_params)
    end
  end

  def executive_profile_params
    params.require(:executive_profile).permit(:full_name, :nit, :professional_card, :phone)
  end

  def employee_profile_params
    params.require(:employee_profile).permit(:first_name, :last_name)
  end

  def personal_info_params
    params.require(:personal_info).permit(
      :marital_status, :nationality, :birth_date, :identification_type,
      :identification_number, :blood_type, :address, :phone_number,
      :emergency_contact_name, :emergency_contact_phone
      # Añade aquí los demás campos de información personal
    )
  end

  def work_info_params
    params.require(:work_info).permit(
      :department, :position, :hire_date, :salary, :contract_type,
      :work_schedule, :supervisor_name, :employee_id, :bank_account_number, :bank_name
      # Añade aquí los demás campos de información laboral
    )
  end

  def authorize_executive
    unless current_user&.executive_profile
      render json: { error: 'Unauthorized. Executive access required.' }, status: :unauthorized
    end
  end
end
