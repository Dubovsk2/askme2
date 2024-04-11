class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :questions
  has_many :authored_questions, class_name: 'Question', dependent: :nullify
  before_validation :create_nickname
  validates :nickname, presence: true
  

  def create_nickname
    self.nickname = self.email.gsub(/@.*$/,'') if self.nickname.blank?
  end
end
