def create_directory
	@students ||= []
end

def add_student(name, cohort = :May)
	create_directory << {name: name, cohort: cohort}
end

def count_students
	@students.length
end

