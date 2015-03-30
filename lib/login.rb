class Login

  def initialize(pass_attempt)
    @pass_attempt = pass_attempt
    @success = false
  end

  def pass_attempt
    @pass_attempt
  end

  def encrypt_pw(pw)
    $salt = 'F8'
    $crypted = pw.crypt($salt)
  end

  def validate_pw(guess)
    guess.crypt($salt) == $crypted
  end

  def log_in(guess)
    if validate_pw(guess)
      @success =  true
    else
      @success = false
    end
  end

  def lemmeseesomeid
    @sucess
  end
end