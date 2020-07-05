module QuestionsHelper
  def define_questions(target)
    case target

    when 'latest' then
      @questions = Question.order(created_at: "DESC")

    when 'answers' then
      sort_array = Question.find(Question.nores.keys)
      sort_array ||= []
      sort_array += Question.left_joins(:answers).where("answers.question_id": nil)
      @question = sort_array
    when 'favorites' then
      find(Question.nofav.keys)

    else
       @questions = Question.order(created_at: "DESC")
    end
  end
end
