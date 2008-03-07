# First, rename programs_semesters to program_semesters, and give it a primary
# key field (id).  Do the same for majors_programs (rename to major_programs with an id)

class Program < ActiveRecord::Base
  has_many :program_semesters
  has_many :semesters, :through => :program_semesters
  
  has_many :major_programs
  has_many :majors, :through => :major_programs
end

class Semester < ActiveRecord::Base
  has_many :program_semesters
  has_many :programs, :through => :program_semesters
end

class ProgramSemester < ActiveRecord::Base
  belongs_to :program
  belongs_to :semester
end

class Major < ActiveRecord::Base
  has_many :major_programs
  has_many :programs, :through => :major_programs
end

class MajorProgram < ActiveRecord::Base
  belongs_to :program
  belongs_to :major
end

# Finding programs, joined with majors and semesters
programs = Program.find(:all, :include => [:majors, :semesters], :conditions => [
  'country = :country AND category = :category AND language = :language AND ' + 
  'semester_id = :semester_id AND major_id = :major_id', 
  params[:program]
])
