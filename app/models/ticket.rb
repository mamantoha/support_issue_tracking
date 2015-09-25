class Ticket < ActiveRecord::Base
  include AASM
  extend FriendlyId

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  friendly_id :display_id

  after_create :generate_display_id

  has_many :comments

  validates :name, presence: true
  validates :email, presence: true, email: true
  validates :subject, presence: true
  validates :body, presence: true

  aasm column: 'status' do
    state :new, initial: true
    state :waited_for_curtomer
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
