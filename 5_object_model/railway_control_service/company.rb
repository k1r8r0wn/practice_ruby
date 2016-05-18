module Company
  def name=(name)
    @name = name
  end

  def produced_by(object)
    "This #{object} produced by #{@name}"
  end
end
