class CheckError
  def continue?
    attempt ||= 0
    attempt += 1
    if attempt < 3
      true
    else
      false
    end
  end

  private

  attr_accessor :attempt
end
