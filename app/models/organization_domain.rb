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

class OrganizationDomain < ApplicationRecord
  belongs_to :organization
  validates :name, presence: true
end
