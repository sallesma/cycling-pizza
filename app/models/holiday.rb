# == Schema Information
#
# Table name: holidays
#
#  id         :integer          not null, primary key
#  country    :string
#  name       :string
#  date       :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Holiday < ApplicationRecord
end
