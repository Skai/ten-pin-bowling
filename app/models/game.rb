class Game < ActiveRecord::Base
  has_many :frames
  after_create :add_frames, :set_active

  def add_frames
    10.times { |i| self.frames << create_frame!(i+1) }
    self.save
  end

  def create_frame!(index)
    Frame.create(
      roll1_pins: 0, 
      roll2_pins: 0,
      roll3_pins: 0,
      idx: index
    )
  end
  
  def set_active
    self.current_frame = 1
    self.current_roll = 1
    self.save
  end

  def get_frame(index)
    self.frames[index - 1]
  end

  def update_score!(pins)
    #work with current frame
    cur_frame = get_frame(self.current_frame)
    
    #if strike
    if pins === 'X'
      cur_frame.set_strike_flag
      pins = 10
    end

    #if spare    
    if pins === '/'
      cur_frame.set_spare_flag
      pins = cur_frame.pins_left
      pins = 10 - cur_frame.roll1_pins if self.current_frame === 10
    end
    pins = pins.to_i

    #check pins number
    raise 'Incorrect Pins Number!' if ( pins > 10 || pins < 0 )
    
    #set pins for separate rolls
    case self.current_roll
    when 1
      cur_frame.roll1_pins = pins
    when 2
      cur_frame.flag = 'spare' if (pins == cur_frame.pins_left)
      cur_frame.roll2_pins = pins
    when 3
      cur_frame.roll3_pins = pins
    end
    cur_frame.increase_score(pins)

    #Additional points if it strike or spare.
    cur1frame = get_frame(self.current_frame - 1)
    cur2frame = get_frame(self.current_frame - 2)
    if cur1frame.is_strike && cur2frame.is_strike && 
      (self.current_roll == 1 || (self.current_roll == 2 && self.current_frame != 10))
      cur1frame.increase_score(pins)
      cur2frame.increase_score(pins)
    elsif cur1frame.is_strike && (self.current_roll == 1 || self.current_roll == 2)
      cur1frame.increase_score(pins)
    elsif cur1frame.is_spare && self.current_roll == 1
      cur1frame.increase_score(pins)
    end
          
    #check if game is finished
    if (self.current_frame == 10)
      if (!cur_frame.is_strike && !cur_frame.is_spare && self.current_roll === 2) || 
         ((cur_frame.is_strike || cur_frame.is_spare) && self.current_roll === 3)
        self.is_finished = true;
      end
    end

    #increment frame
    if (self.current_roll === 2 && self.current_frame != 10)
      self.current_frame += 1
    end

    #increment roll
    if (self.current_roll === 2 && self.current_frame == 10 && (cur_frame.is_strike || cur_frame.is_spare))
      self.current_roll = 3  
    else
      self.current_roll = (self.current_roll === 1) ? 2 : 1
    end
    
    #if is strike
    if (cur_frame.is_strike && self.current_frame != 10)
      self.current_frame += 1
      self.current_roll = 1
    end

    #update total score
    sum = 0
    self.frames.each { |frame| sum += frame.score }
    self.score = sum
    
    #save the game
    self.save
  end

  def pins_left
    get_frame(self.current_frame).pins_left
  end

  def is_last_strike
    self.current_frame == 10 && get_frame(10).is_strike
  end

  def is_last_spare
    self.current_frame == 10 && get_frame(10).is_spare
  end
end
