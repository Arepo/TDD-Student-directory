require 'directory2'

describe 'creating a directory' do 

	it 'the directory is empty when first used' do
		expect(create_directory).to be_empty
	end

	it 'adds students to the directory' do
		add_student('Bob')
		expect(create_directory).not_to be_empty
	end 

	it 'checks that the added student is the right one' do
		add_student('Fred')
		expect(@students[0][:name]).to eq 'Fred'
	end

	it 'knows if there are 2 students' do
		add_student('Fred')
		add_student('Bob')
		expect(count_students).to eq 2
	end

	it 'knows if there is 1 student' do
		add_student('Bob')
		expect(count_students).to eq 1
	end

	it 'assumes students are from may cohort if not specified' do
		add_student('James')
		expect(create_directory[0][:cohort]).to eq :May
	end

	it 'allows you to specify the cohort' do
		add_student('James', :November)
		expect(create_directory[0][:cohort]).to eq :November
	end

	it 'assumes the year is 2014 if not specified' do
		add_student(James, wibble)
		expect(create_directory[0][:year]).to eq 2014
	end
	
end