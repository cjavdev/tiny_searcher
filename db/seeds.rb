def get(resource)
  JSON.parse(File.read(Rails.root.join("data", "#{ resource }.json")))
end

puts "Loading organizations."
get("organizations").each do |data|
  organization = Organization.find_or_create_by(id: data["_id"])

  organization.update(
    external_id:      data["external_id"],
    created_at:       data["created_at"],
    name:             data["name"],
    shared_tickets:   data["shared_tickets"],
  )

  data["domain_names"].each do |domain|
    organization.domains.find_or_create_by(name: domain)
  end

  data["tags"].each do |tag|
    organization.tags.find_or_create_by(name: tag)
  end
end

puts "Loading users."
get("users").each do |data|
  user = User.find_or_create_by(id: data["_id"])
  user.update!(
    external_id:      data["external_id"],
    created_at:       data["created_at"],
    name:             data["name"],
    alias:            data["alias"],
    verified:         data["verified"],
    shared:           data["shared"],
    locale:           data["locale"],
    timezone:         data["timezone"],
    last_login_at:    data["last_login_at"],
    email:            data["email"],
    phone:            data["phone"],
    signature:        data["signature"],
    organization_id:  data["organization_id"],
    suspended:        data["suspended"],
    role:             data["role"],
  )
  data["tags"].each do |tag|
    user.tags.find_or_create_by(name: tag)
  end
end

puts "Loading tickets."
get("tickets").each do |data|
  ticket = Ticket.find_or_create_by(id: data["_id"])
  ticket.update!(
    external_id:      data["external_id"],
    created_at:       data["created_at"],
    ticket_type:      data["type"],
    subject:          data["subject"],
    description:      data["description"],
    priority:         data["priority"],
    status:           data["status"],
    submitter_id:     data["submitter_id"],
    assignee_id:      data["assignee_id"],
    organization_id:  data["organization_id"],
    has_incidents:    data["has_incidents"],
    due_at:           data["due_at"],
    via:              data["via"],
  )
  data["tags"].each do |tag|
    ticket.tags.find_or_create_by(name: tag)
  end
end
