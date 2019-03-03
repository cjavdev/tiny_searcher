def get(resource)
  JSON.parse(File.read(Rails.root.join("data", "#{ resource }.json")))
end

puts "Loading organizations."
get("organizations").each do |data|
  Organization.find_or_create_by(
    id:               data["_id"],
    created_at:       data["created_at"],
    name:             data["name"],
    shared_tickets:   data["shared_tickets"],
  ) do |org|
    data["domain_names"].each do |domain|
      org.domain_names.find_or_create_by(name: domain)
    end

    data["tags"].each do |tag|
      org.tags.find_or_create_by(name: tag)
    end
  end
end
