class Predictor::Base

  def predict(*_args)
    raise "#{self.class.name} needs to implement method #{__method__}!"
  end

end
