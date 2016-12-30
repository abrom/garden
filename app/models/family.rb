class Family < ActiveRecord::Base
  has_many :genora, class_name: 'Genus'
  has_many :species, through: :genora
  has_many :plants, through: :species

  enum major_group: [:angiosperms, :gymnosperms, :pteridophytes, :bryophytes]
end
