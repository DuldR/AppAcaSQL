class Course < ApplicationRecord

    has_many(
        :enrollments,
        class_name: 'Enrollment',
        foreign_key: :course_id,
        primary_key: :id
    )

    has_one(
        :preq,
        class_name: 'Course',
        foreign_key: :id,
        primary_key: :prereq_id
    )

    has_one(
        :instructor,
        class_name: 'User',
        foreign_key: :id,
        primary_key: :instructor_id
    )

    has_many :users, through: :enrollments, source: :user



end
