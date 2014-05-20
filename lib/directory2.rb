require 'csv'

def students
	@students ||= []
end

def add_student(name, cohort = :May, year = 2014)
	students << {name: name, cohort: cohort, year: year}
end

def count_students
	@students.length
end

def list_students
	list = students.map do |student|
	"#{student[:name]} (#{student[:cohort]} cohort, #{student[:year]})"
	end
	list.join("\n")
end

def delete_student(name, cohort = auto_find_cohort(name))
	students.delete_if { |student| student[:name] == name && student[:cohort] == cohort}
end

def auto_find_cohort(name)
	student_id = students.select do |student|
		student[:name] == name
	end
	student_id[0][:cohort]
end

def save_student_list
	CSV.open("students.csv", "w") do |line|
		students.each do |student|
			line << [student[:name], student[:cohort], student[:year]]
		end
	end
end

add_student("Steve", :May)
add_student("John", :November, 2013)
