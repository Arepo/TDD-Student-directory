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

list_students