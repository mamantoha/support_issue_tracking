class User < ActiveRecord::Base
  enum role: [:user, :manager, :admin]
  after_initialize :set_default_role, if: :new_record?

  has_many :comments

  validates :username, presence: true
  validates :role, presence: true
  validates :email, presence: true, email: true

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
