class Frame < ActiveRecord::Base
  belongs_to :game

  def pins_left
    if (self.idx === 10 && (self.is_strike || self.is_spare))
      10
    else
      10 - self.score
    end
  end

  def increase_score(pins)
    self.score += pins
    self.save
  end

  def set_strike_flag
    self.flag = 'strike'
    self.save
  end

  def set_spare_flag
    self.flag = 'spare'
    self.save
  end

  def is_spare
    self.flag === 'spare'
  end

  def is_strike
    self.flag === 'strike'
  end
end
