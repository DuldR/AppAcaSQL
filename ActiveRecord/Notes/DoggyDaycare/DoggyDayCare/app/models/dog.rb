# == Schema Information
#
# Table name: dogs
#
#  id   :bigint           not null, primary key
#  name :string           not null
#
class Dog < ApplicationRecord

    validates :name, presence: true
    validate :check_name_length

    def check_name_length
        unless self.name.length >= 4
            errors[:name] << "Name is too short, must be longer than 4 or more characters"
        end
    end

    # def toys
    #     Toy.where { dog_od: self.id }

    # end

    has_many(:toys, { 
        primary_key: :id,
        foreign_key: :dog_id,
        class_name: :Toy
    })
end
