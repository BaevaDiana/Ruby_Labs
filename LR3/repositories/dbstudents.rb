class DBStudent
  private_class_method :new
  @instance_mutex = Mutex.new

  def initialize
    @client = Mysql2::Client.new(
      host: 'localhost',
      username: 'root',
      password: 'password',
      database: 'student_db'
    )
  end

  def self.instance
    return @instance if @instance

    @instance_mutex.synchronize do
      @instance ||= new
    end
    @instance
  end

  def prepare_exec(statement, *params)
    @client.prepare(statement).execute(*params)
  end

  def query(statement)
    @client.query(statement)
  end

end
