# == Schema Information
#
# Table name: organization_domains
#
#  id              :bigint(8)        not null, primary key
#  name            :string           not null
#  organization_id :bigint(8)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_organization_domains_on_name                      (name)
#  index_organization_domains_on_organization_id           (organization_id)
#  index_organization_domains_on_organization_id_and_name  (organization_id,name) UNIQUE
#

require 'rails_helper'

RSpec.describe OrganizationDomain, type: :model do
  it { should belong_to(:organization) }
  it { should validate_presence_of(:name) }
end
