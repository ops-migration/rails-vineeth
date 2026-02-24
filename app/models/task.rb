class Task < ApplicationRecord
  validates :title, presence: true, length: { minimum: 2, maximum: 100 }
  validates :status, inclusion: { in: %w[pending in_progress completed] }

  scope :by_status, ->(status) { where(status: status) if status.present? }
  scope :recent, -> { order(created_at: :desc) }

  before_validation :set_default_status

  private

  def set_default_status
    self.status ||= "pending"
  end
end
