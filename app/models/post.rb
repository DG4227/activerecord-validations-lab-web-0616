class Post < ActiveRecord::Base
	validates :title, presence: true
	validates :content, length: { minimum: 20 }
	validates :summary, length: {maximum: 100}
	validates :category, inclusion: {in: %w(Fiction Non-Fiction),
    message: "bad cato"}
  validate :clickbaity?, on: :create

  CLICKBAIT_PATTERNS = [
    /Won't Believe/i,
    /Secret/i,
    /Top [0-9]*/i,
    /Guess/i
  ]

  def clickbaity?
    if CLICKBAIT_PATTERNS.none? { |pat| pat.match title }
      errors.add(:title, "must be clickbait")
    end
  end

end
