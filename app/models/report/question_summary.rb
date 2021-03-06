# models a summary of the answers for a question on a form
class Report::QuestionSummary
  # the questioning we're summarizing
  attr_reader :questioning
    
  # array containing the individual items of information in the summary
  attr_reader :items

  # the column headers, if any
  attr_reader :headers

  # the number of null answers we encountered
  attr_reader :null_count

  attr_reader :display_type
  attr_reader :overall_header

  def initialize(attribs)
    # save attribs
    attribs.each{|k,v| instance_variable_set("@#{k}", v)}
  end

  def qtype
    questioning.qtype
  end

  # gets a set of objects that allow this summary to be compared to others for clustering
  def signature
    [display_type, questioning.option_set, headers]
  end

  def as_json(options = {})
    h = super(options)
    h[:questioning] = questioning.as_json(
      :only => [:id, :rank], 
      :methods => [:code, :name, :referring_condition_ranks], 
      :include => {:condition => {:only => [], :methods => :to_s}}
    )
    h[:items] = items
    h[:null_count] = null_count
    h
  end
end