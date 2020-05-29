class Enrollment < ApplicationRecord

    belongs_to(
        :course,
        class_name: 'Course',
        foreign_key: :course_id,
        primary_key: :id
    )
end
