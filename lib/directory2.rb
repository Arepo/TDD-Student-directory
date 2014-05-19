def create_directory
	@students ||= []
end

def add_student(name, cohort = :May, year = 2014)
	create_directory << {name: name, cohort: cohort, year: year}
end

def count_students
	@students.length
end

