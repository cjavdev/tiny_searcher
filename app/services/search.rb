class Search
  PER_RESOURCE_LIMIT = 10
  RESOURCES = [
    User,
    Organization,
    Ticket,
    OrganizationDomain,
    Tag
  ]

  def initialize(query)
    @query = query
    @errors = []
  end

  def where_clauses
    return @where_clauses if @where_clauses

    @where_clauses = @query.split(" ").map do |clause|
      field, value = clause.split(":")
      if !supported_fields.include?(field)
        errors << "Unsupported field `#{ field }`"
      end
      [field, value]
    end.to_h
    if where_clauses.has_key?("name")
      where_clauses[:tags] = {name: where_clauses["name"]}
      where_clauses[:domains] = {name: where_clauses["name"]}
    end
    @where_clauses
  end

  def errors
    @errors
  end

  def results
    resources.inject([]) do |results, resource|
      results + send(resource.name.tableize.to_sym)
    end
  end

  def resources
    RESOURCES
  end

  def supported_fields
    @supproted_fields ||= resources.map(&:column_names).flatten
  end

  RESOURCES.each do |resource|
    plural_name = resource.name.tableize
    plural_name_clauses = "#{ plural_name }_clauses"
    define_method(plural_name_clauses) do
      where_clauses.select do |field, value|
        resource.column_names.include?(field)
      end.to_h
    end

    define_method(plural_name) do
      where_clause = send(plural_name_clauses.to_sym)
      if where_clause.empty?
        resource.none
      else
        resource.where(where_clause).limit(PER_RESOURCE_LIMIT)
      end
    end
  end
end
