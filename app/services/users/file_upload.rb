module Users
  class FileUpload
    FileResults = Struct.new(:valid_rows, :invalid_rows)

    attr_accessor :file, :file_result, :valid_rows

    def initialize(file)
      @file = file
      @file_result = FileResults.new([], [])
      @valid_rows = []
    end

    def perform
      CSV.foreach(file.path, headers: true).with_index(1) do |row, index|
        user = ::User.new(name: row["name"], password: row["password"].to_s)

        if user.valid?
          file_result.valid_rows << { row_number: index }
          valid_rows << user
        else
          file_result.invalid_rows << { row_number: index, errors: user.errors.full_messages }
        end
      rescue StandardError => e
        file_result.invalid_rows << { row_number: index, errors: e.message }
      end

      insert_valid_users

      file_result
    end

    private

    def insert_valid_users
      User.import(valid_rows, validate: false)
    end
  end
end
