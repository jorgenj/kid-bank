class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :accounts

  def self.first_admin
    password = SecureRandom.hex

    user = User.first_or_create!({email: "#{SecureRandom.hex}@#{SecureRandom.hex}.com",
                           password: password,
                           password_confirmation: password }) do |if_created|
      Role.admin.users << if_created
    end

    user
  end
end
