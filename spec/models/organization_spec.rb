# == Schema Information
#
# Table name: organizations
#
#  id             :bigint(8)        not null, primary key
#  external_id    :string
#  name           :string
#  details        :string
#  shared_tickets :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_organizations_on_external_id     (external_id)
#  index_organizations_on_name            (name)
#  index_organizations_on_shared_tickets  (shared_tickets)
#

require 'rails_helper'

RSpec.describe Organization, type: :model do
  it { should have_many(:tags) }
  it { should have_many(:domains) }
end
