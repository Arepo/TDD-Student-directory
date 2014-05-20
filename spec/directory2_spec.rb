require 'directory2'

describe 'adding a student to the directory' do 

	it 'the directory is empty when first used' do
		expect(students).to be_empty
	end

	it 'adds students to the directory' do
		add_student('Bob')
		expect(students).not_to be_empty
	end 

	it 'checks that the student saved is the student entered' do
		add_student('Fred')
		expect(@students[0][:name]).to eq 'Fred'
	end

	it 'assumes students are from may cohort if not specified' do
		add_student('James')
		expect(students[0][:cohort]).to eq :May
	end

	it 'accepts a cohort different from the default' do
		add_student('James', :November)
		expect(students[0][:cohort]).to eq :November
	end

	it 'assumes the year is 2014 if not specified' do
		add_student('James', :February)
		expect(students[0][:year]).to eq 2014
	end

	it 'accepts a year different from the default' do
		add_student('James', nil, 2013)
		expect(students[0][:year]).to eq 2013
	end
	
end

describe 'it lists students' do

	it 'in the following way "Bob (May cohort)"' do
		add_student('Bob', :May, 2014)
		expect(list_students).to eq "Bob (May cohort, 2014)"
	end

	it 'having also met Roy' do
		add_student('Roy', :November, 2013)
		expect(list_students).to eq "Roy (November cohort, 2013)"
	end

	it 'can list more than one student, Bob and Roy' do
		add_student('Roy', :November, 2013)
		add_student('Bob', :May, 2014)
		expect(list_students).to eq "Roy (November cohort, 2013)\nBob (May cohort, 2014)"
	end

end

describe 'pluralises appropriately' do

	it 'knows if there are 2 students' do
		add_student('Fred')
		add_student('Bob')
		expect(count_students).to eq 2
	end

	it 'knows if there is 1 student' do
		add_student('Bob')
		expect(count_students).to eq 1
	end

end 

describe 'deleting students' do

	it 'deletes students by first name' do
		add_student("Steve")
		add_student("Bob")
		expect(delete_student("Steve")).to eq [{name: "Bob", cohort: :May, year: 2014}]
	end

	it 'actually deletes students by first name' do
		add_student("Steve")
		add_student("Bob")
		expect(delete_student("Bob")).to eq [{name: "Steve", cohort: :May, year: 2014}]
	end

	it 'knows to delete May Steve' do
		add_student("Steve", :May)
		add_student("Steve", :November, 2013)
		expect(delete_student("Steve", :May)).to eq [{name: "Steve", cohort: :November, year: 2013}]
	end
end

describe 'writing to CSV file' do

	# it 'check file called students.csv exists' do
	# 	expect(File.exists?("students.csv")).to be_true
	# end

	it 'leaves behind a file called students.csv' do
		save_student_list
		expect(File.exists?("students.csv")).to be_true
	end

	it 'puts current student list into students.csv' do
		add_student("Steve", :May)
		add_student("John", :November, 2013)
		save_student_list
		expect(CSV.readlines("students.csv")).to eq [["Steve", "May", "2014"], ["John", "November", "2013"]]
	end
end
