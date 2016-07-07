class Post < ActiveRecord::Base
	validates :title, presence: true
	validates :content, length: { minimum: 20 }
	validates :summary, length: {maximum: 100}
	validates :category, inclusion: {in: %w(Fiction Non-Fiction),
    message: "bad cato"}
  validate :clickbaity?, on: :create


  def clickbaity?
    bait = [/Won't Believe/, /Secret/, /Top/, /Guess/]
    if bait.none? { |phrase| phrase.match title }
      errors.add(:non_clickbait, "MOAR CLICKBAIT")
    end
  end

end
