# == Schema Information
#
# Table name: tags
#
#  id            :bigint(8)        not null, primary key
#  taggable_type :string
#  taggable_id   :bigint(8)
#  name          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_tags_on_taggable_id_and_taggable_type_and_name  (taggable_id,taggable_type,name) UNIQUE
#  index_tags_on_taggable_type_and_taggable_id           (taggable_type,taggable_id)
#

class Tag < ApplicationRecord
  belongs_to :taggable, polymorphic: true
  validates :name, presence: true
end
