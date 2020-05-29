class Course < ApplicationRecord

    has_many(
        :enrollment,
        class_name: 'Enrollment',
        foreign_key: :course_id,
        primary_key: :id
    )

end
