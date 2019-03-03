# == Schema Information
#
# Table name: tickets
#
#  id              :bigint(8)        not null, primary key
#  external_id     :string
#  type            :string
#  subject         :string
#  description     :text
#  priority        :string
#  status          :string
#  submitter_id    :integer
#  assignee_id     :integer
#  organization_id :bigint(8)
#  has_incidents   :boolean
#  due_at          :datetime
#  via             :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_tickets_on_assignee_id      (assignee_id)
#  index_tickets_on_external_id      (external_id)
#  index_tickets_on_organization_id  (organization_id)
#  index_tickets_on_priority         (priority)
#  index_tickets_on_status           (status)
#  index_tickets_on_submitter_id     (submitter_id)
#  index_tickets_on_type             (type)
#

class Ticket < ApplicationRecord
  belongs_to :organization, optional: true
  has_many :tags, as: :taggable

  def to_s
    "Ticket (#{id}): #{subject}"
  end
end
