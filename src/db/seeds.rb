10.times do
  volunteer = Person.create(
    name: Faker::Name.name_with_middle
  )
  Volunteer.create(
    person: volunteer
  )
end 

50.times do 
  student = Person.create(
    name: Faker::Name.name_with_middle
  )
  Student.create(
    person: student
  )
end 

def generate_volunteer
  volunteers = []
  rand(1..3).times do 
    v = Volunteer.find(rand(1..10))
    volunteers.push(v)
  end 
  volunteers
end

def generate_week
  week_days = []
  rand(1..3).times do 
    wd = WeekDay.find(rand(1..7))
    week_days.push(wd)
  end 
  week_days
end

def generate_student
  students = []
  rand(1..25).times do 
    s = Student.find(rand(1..50))
    students.push(s)
  end 
  students
end 

activities = Activity.create!([
  {
    name: "Balé",
    location: "Centro Comunitário Nossa Senhora Medianeira",
    description: Faker::Lorem.paragraph_by_chars(number: 180, supplemental: false),
    max_capacity: rand(20..50),
    starts_at: Time.parse("09:00"),
    ends_at: Time.parse("11:00"),
    volunteers: generate_volunteer,
    week_days: generate_week,
    students: generate_student
  },
  {
    name: "Jiu Jitsu",
    location: "Centro Comunitário Nossa Senhora Medianeira",
    description: Faker::Lorem.paragraph_by_chars(number: 180, supplemental: false),
    max_capacity: rand(20..50),
    starts_at: Time.parse("18:00"),
    ends_at: Time.parse("19:00"),
    volunteers: generate_volunteer,
    week_days: generate_week,
    students: generate_student
  },
  {
    name: "Muai Thay", 
    location: "Centro Comunitário Nossa Senhora Medianeira",
    description: Faker::Lorem.paragraph_by_chars(number: 180, supplemental: false),
    max_capacity: rand(20..50),
    starts_at: Time.parse('19:00'),
    ends_at: Time.parse('20:30'),
    volunteers: generate_volunteer,
    week_days: generate_week,
    students: generate_student
  },
  {
    name: "Reforço Escolar", 
    location: "Centro Comunitário Nossa Senhora Medianeira",
    description: Faker::Lorem.paragraph_by_chars(number: 180, supplemental: false),
    max_capacity: rand(20..50),
    starts_at: Time.parse('15:00'),
    ends_at: Time.parse('17:00'),
    volunteers: generate_volunteer,
    week_days: generate_week,
    students: generate_student
  }
])
