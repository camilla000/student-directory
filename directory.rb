@students = []

def input_students
  puts "Please enter the names of students"
  puts "To finish, hit return twice"
  name = gets.chomp
  while !name.empty?
    puts "Which cohort is the student in?"
    cohort = gets.chomp
    if cohort == ""
      cohort = "Not assigned"
    else
      cohort = cohort.to_sym
    end

    puts "What is the student's nationality?"
    nationality = gets.chomp

    puts "What is the student's age?"
    age = gets.chomp

    @students << { name: name, cohort: cohort, nationality: nationality, age: age }

    puts "Now we have #{@students.count} students"
    puts "Please enter another name, or press enter to skip"
    name = gets.chomp
  end
end

def print_header
  puts "The students of Makers Academy"
  puts "--------------------------------"
end

def group_cohort(students)
  groups = {}
  students.each do |student|
    cohort = student[:cohort].to_sym
    if groups[cohort] == nil
      groups[cohort] = []
    end
    groups[cohort].push(student)
  end
  groups
end

def print_students_list(students)
  students.each do |cohort, cohort_students|
    puts " * #{cohort.capitalize} Cohort *".center(30)
    cohort_students.each_with_index do |identity, index|
      puts "#{index + 1}. #{identity[:name]}
            nationality: #{identity[:nationality]}
            age: #{identity[:age]}".center(30)
    end
  end
end

def print_footer(students)
  if students.count == 1
    puts "Overall, we have 1 great student"
  else
    puts "Overall, we have #{students.count} great students"
  end
end

def print_menu
  #1. Print the menu and ask user what to do
  puts "1. Input the students"
  puts "2. Show the students"
  puts "9. Exit" # 9 because we'll be adding more options
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "9"
    exit
  else
    puts "I don't know what you mean, try again"
  end
end

def show_students
  grouped_students = group_cohort(@students)
  print_header
  print_students_list(grouped_students)
  print_footer(@students)
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

interactive_menu

