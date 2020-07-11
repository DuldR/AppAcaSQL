require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    # ...

    # You cant do this yet as human hasnt been defined! Do it inside of the define method which will ensure it gets called inside of an instance which relies on the user to ensure the associations are present.
    # through_options = self.assoc_options[through_name]
    # source_options = through_options.model_class.assoc_options[source_name]


    define_method(name) do

      through_options = self.assoc_options[through_name]source_options = through_options.model_class.assoc_options[source_name]

      fkey = through_options.model_class.assoc_options[source_name].foreign_key


      print fkey
      # data = DBConnection.execute(<<-SQL)
      #   SELECT
      #     "#{self.table_name}".*
      #   FROM
      #     "#{source_options.model_class.table_name}"
      #   WHERE
      #     "#{fkey}" = "#{pkey}"
      # SQL

      # parse_all(data)
    end

  

  end
end
