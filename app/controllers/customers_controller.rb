# frozen_string_literal: true

class CustomersController < ApplicationController
  before_action :set_user, only: :login
  before_action :authenticate_request, only: %i[update_credit_card update_customer_info show update]

  def create
    @customer = Customer.new customer_params
    if @customer.save
      @token = JsonWebToken.encode(id: @customer.customer_id, email: @customer.email)
      json_response(:create, :created)
    else
      custom_fields_validations
    end
  end

  def show
    json_response(:show, :ok)
  end

  def update
    fields = %i[name email password day_phone eve_phone mob_phone]
    @response = required_fields('USR_02', validates_required_fields(fields, params)) unless validates_required_fields(fields, params).empty?
    return json_response(:update, :bad_request) if @response&.any?

    customer_params.keep_if { |field, _value| fields.include?(field) }
    @current_user.update(customer_params)

    return @response = usr_04 if key_exist?(@current_user, :email, :taken)
    return @response = usr_03 if key_exist?(@current_user, :email, :invalid)
    return @response = usr_06('eve_phone') if key_exist?(@current_user, :eve_phone, :invalid)
    return @response = usr_06('day_phone') if key_exist?(@current_user, :day_phone, :invalid)
    return @response = usr_06('mob_phone') if key_exist?(@current_user, :mob_phone, :invalid)

    json_response(:update)
  end

  def login
    if @customer&.valid_password?(params[:password])
      @token = JsonWebToken.encode(id: @customer.customer_id, email: @customer.email)
      json_response(:login, :ok)
    else
      @response = usr_01
    end
  end

  def update_credit_card
    @response = required_fields('USR_02', [:credit_card]) unless validates_required_fields([:credit_card], params).empty?
    return json_response(:update_credit_card, :bad_request) if @response&.any?

    @current_user.update(credit_card: params[:credit_card])

    if key_exist?(@current_user, :credit_card, :invalid)
      @response = usr_08
      status = :bad_request
    end
    json_response(:update_credit_card, status || :ok)
  end

  def update_customer_info
    fields = %i[address_1 city region postal_code country shipping_region_id]
    @response = required_fields('USR_02', validates_required_fields(fields, params)) unless validates_required_fields(fields, params).empty?
    return json_response(:update_customer_info, :bad_request) if @response&.any?

    customer_params.keep_if { |field, _value| fields.include?(field) }
    @current_user.update(customer_params)
    if key_exist?(@current_user, :shipping_region, :blank)
      @response = usr_09(params[:shipping_region_id])
      status = :bad_request
    end
    json_response(:update_customer_info, status || :ok)
  end

  private

  def customer_params
    params.permit(
      :customer_id,
      :name,
      :email,
      :password,
      :credit_card,
      :address_1,
      :address_2,
      :city,
      :region,
      :postal_code,
      :country,
      :shipping_region_id,
      :day_phone,
      :eve_phone,
      :mob_phone
    )
  end

  def set_user
    @customer = Customer.find_by!(email: params[:email].to_s.downcase)
  rescue ActiveRecord::RecordNotFound
    @response = usr_05
    json_response(:set_user, :not_found)
  end

  def custom_fields_validations
    fields = @customer.errors.messages.keys
    return @response = required_fields('USR_02', get_blank_fields(@customer, fields)) if validate_empty_model_fields?(@customer, fields)
    return @response = usr_04 if key_exist?(@customer, :email, :taken)
    return @response = usr_03 if key_exist?(@customer, :email, :invalid)
    return @response = usr_08 if key_exist?(@customer, :credit_card, :invalid)
    return @response = usr_06('eve_phone') if key_exist?(@customer, :eve_phone, :invalid)
    return @response = usr_06('day_phone') if key_exist?(@customer, :day_phone, :invalid)
    return @response = usr_06('mob_phone') if key_exist?(@customer, :mob_phone, :invalid)
  end

  def usr_03
    {
      status: 400,
      code: 'USR_03',
      message: 'Email is invalid',
      field: 'Email'
    }
  end

  def usr_04
    {
      status: 400,
      code: 'USR_04',
      message: 'Email already exists',
      field: 'Email'
    }
  end

  def usr_05
    {
      status: 400,
      code: 'USR_05',
      message: 'User is not registered',
      field: 'Email'
    }
  end

  def usr_08
    {
      status: 400,
      code: 'USR_08',
      message: 'Credit Card is invalid',
      field: 'Credit Card'
    }
  end

  def usr_06(field)
    {
      status: 400,
      code: 'USR_06',
      message: 'Invalid phone number',
      field: field
    }
  end

  def usr_01
    {
      status: 400,
      code: 'USR_01',
      message: 'Email or Password is invalid',
      field: 'Email/Password'
    }
  end

  def usr_09(id)
    {
      status: 400,
      code: 'USR_09',
      message: "There is no associated Shipping Region with ID #{id}",
      field: 'shipping_region_id'
    }
  end
end
