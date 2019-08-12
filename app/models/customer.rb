# frozen_string_literal: true

class Customer < ApplicationRecord
  self.table_name = 'customer'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :validatable

  belongs_to :shipping_region
  has_many :reviews
  has_many :orders

  validates :name, :encrypted_password, presence: true
  validates :address_1, presence: true, allow_blank: true
  validates :city, presence: true, allow_blank: true
  validates :region, presence: true, allow_blank: true
  validates :postal_code, presence: true, allow_blank: true
  validates :country, presence: true, allow_blank: true
  validates :shipping_region_id, presence: true, allow_blank: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /@/ }
  validates :credit_card, credit_card_number: true, allow_blank: true
  validates :day_phone, phone: { allow_blank: true,  types: %i[fixed_or_mobile personal_number mobile] }
  validates :eve_phone, phone: { allow_blank: true,  types: %i[fixed_or_mobile personal_number mobile] }
  validates :mob_phone, phone: { allow_blank: true,  types: %i[fixed_or_mobile personal_number mobile] }
  before_validation :downcase_email

  def downcase_email
    self.email = email.downcase.strip if email.present?
  end
end
