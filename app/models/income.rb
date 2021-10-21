class Income < Transaction
  validates_presence_of :date
  validates :amount, presence:true, numericality: { greater_than: 0.0 }

  after_initialize :init

  def init
    self.category = nil
  end
end