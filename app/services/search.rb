class Search
  PER_RESOURCE_LIMIT = 10
  RESOURCES = [
    User.left_outer_joins(:tags),
    Organization.left_outer_joins(:tags, :domains),
    Ticket.left_outer_joins(:tags)
  ]

  attr_reader :resources, :errors

  def initialize(query, resources=RESOURCES)
    @query = query
    @errors = []
    @resources = resources
  end

  def where_clauses
    return @where_clauses if @where_clauses

    @where_clauses = @query.split(" ").map do |clause|
      field, value = clause.split(":")
      if value.nil?
        errors << "Queries must be in the form <field>:<value>."
      elsif !supported_fields.include?(field)
        errors << "Unsupported field `#{ field }`."
      end
      [field, value]
    end.to_h

    # TODO: make this so the keys were all the same type. Also, maybe generate
    # dynamically?
    if where_clauses.has_key?("name")
      where_clauses["tags"] = {"name" => where_clauses["name"]}
      where_clauses["domains"] = {"name" => where_clauses["name"]}
    end

    @where_clauses
  end

  def results
    resources.inject([]) do |results, resource|
      results + send(resource.name.tableize.to_sym)
    end
  end

  def supported_fields
    @supproted_fields ||= resources.map(&:column_names).flatten
  end

  # Define two methods per resource. One for getting the where clause and one
  # for getting the resultset. This generates something like...
  #
  # def users_clauses
  #   # where clause filtered to fields applicable to users.
  # end
  #
  # def users
  #   # users filtered by users clause, limited to PER_RESOURCE_LIMIT
  # end
  RESOURCES.each do |resource|
    plural_name = resource.name.tableize
    plural_name_clauses = "#{ plural_name }_clauses"
    plural_name_related_clauses = "#{ plural_name }_related_clauses"

    define_method(plural_name_related_clauses) do
      # Valid fields are any direct column, or association.
      fields = resource.reflect_on_all_associations.map(&:name).map(&:to_s)
      where_clauses.select do |field, value|
        fields.include?(field)
      end.to_h
    end

    define_method(plural_name_clauses) do
      # Valid fields are any direct column, or association.
      fields = resource.column_names
      where_clauses.select do |field, value|
        fields.include?(field)
      end.to_h
    end

    define_method(plural_name) do
      results = resource.all
      where_clause = send(plural_name_clauses.to_sym)
      where_related_clause = send(plural_name_related_clauses.to_sym)
      return [] if where_clause.empty? && where_related_clause.empty?

      if !where_clause.empty?
        results = results.where(where_clause)
      end

      if !where_related_clause.empty?
        where_related_clause.each do |field, value|
          results = results.or(resource.where(field => value))
        end
      end

      results.distinct
    end
  end
end
