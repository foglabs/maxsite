class Login

  def initialize(pass_attempt)
    @pass_attempt = pass_attempt
    @success = false
  end

  def pass_attempt
    @pass_attempt
  end

  def validate_pw
    @pass_attempt == 'SHININGFINGER' ? @success = true : nil
  end

  def lemmeseesomeid
    @sucess
  end
end
