class User < ActiveRecord::Base
  acts_as_paranoid

  enum role: [:user, :manager, :admin]
  after_initialize :set_default_role, if: :new_record?

  has_many :comments
  has_many :tickets, class_name: 'Ticket', foreign_key: 'assignee_id'

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :role, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
