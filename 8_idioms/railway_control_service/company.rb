module Company
  def company_name=(name)
    @company_name = name
  end

  def produced
    "This product produced by #{@company_name}"
  end
end
