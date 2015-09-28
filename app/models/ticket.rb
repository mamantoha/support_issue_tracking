class Ticket < ActiveRecord::Base
  include AASM
  extend FriendlyId

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  friendly_id :display_id

  after_create :generate_display_id

  has_many :comments, dependent: :destroy
  belongs_to :assignee, -> { unscope(where: :deleted_at) }, class_name: 'User', foreign_key: 'assignee_id'


  validates :name, presence: true
  validates :email, presence: true, email: true
  validates :subject, presence: true
  validates :body, presence: true

  scope :assigned_to, ->(assignee_id) { where(assignee_id: assignee_id) }
  scope :unassigned, -> { where(assignee_id: nil, status: %w(new)) }
  scope :opened, -> { where(status: %w(new waited_for_customer on_hold)) }
  scope :on_holded, -> { where(status: %w(on_hold)) }
  scope :completed, -> { where(status: %w(completed canceled)) }

  aasm column: 'status' do
    state :new, initial: true # Waiting for Staff Response
    state :waited_for_customer
    state :on_hold
    state :canceled
    state :completed
  end

  after_create do |ticket|
    ticket.update_attributes(display_id: generate_display_id)
  end

  protected

  def generate_display_id
    # "ABC-4F-ABC-8D-ABC"
    "#{Array.new(3) { [*"A".."Z", *"0".."9"].sample }.join}-#{SecureRandom.hex(1).upcase}-#{Array.new(3) { [*"A".."Z", *"0".."9"].sample }.join}-#{SecureRandom.hex(1).upcase}-#{Array.new(3) { [*"A".."Z", *"0".."9"].sample }.join}"
  end
end

Ticket.import
