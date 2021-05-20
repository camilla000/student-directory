require "csv"
@students = []

def input_students
  puts "Please enter the names of students"
  puts "To finish, hit return twice"
  name = STDIN.gets.chomp
  while !name.empty?
    puts "Which cohort is the student in?"
    cohort = STDIN.gets.chomp
    if cohort == ""
      cohort = "Not assigned"
    else
      cohort = cohort.to_sym
    end

    puts "What is the student's nationality?"
    nationality = STDIN.gets.chomp

    puts "What is the student's age?"
    age = STDIN.gets.chomp

    @students << student_hash([name, cohort, nationality, age])

    puts "Now we have #{@students.count} students"
    puts "Please enter another name, or press enter to skip"
    name = STDIN.gets.chomp
  end
end

def student_hash(array)
  identity_hash = {
    name: array[0],
    cohort: array[1],
    nationality: array[2],
    age: array[3],
  }
  identity_hash
end

def print_header
  puts "The students of Villains Academy"
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
  puts "3. Save the list to a file"
  puts "4. Load the list from the file"
  puts "9. Exit"
end

def process(selection)
  case selection
  when "1"
    input_students
    puts "You've added a student"
  when "2"
    show_students
  when "3"
    save_students
    puts "You have saved students' details to the file."
  when "4"
    load_students
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
    process(STDIN.gets.chomp)
  end
end

def save_students
  puts "Enter the name of the file to save: "
  filename = STDIN.gets.chomp
  CSV.open(filename, "w")
  @students.each do |student|
    student_data =
      [student[:name], student[:cohort], student[:nationality], student[:age]]
    file.puts student_data.join(",")
  end
  file.close
end

def load_students(filename = "students.csv")
  puts "Enter the name of the file you want to open: "
  filename = STDIN.gets.chomp
  file = CSV.open(filename, "r")
  file.readlines.each do |line|
    student = line.chomp.split(",")
    @students << student_hash(student)
  end
  file.close
end

def try_load_students
  filename = "students.csv"
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

interactive_menu
