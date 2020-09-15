module ActivitiesHelper
  def find_color(percentage)
    case percentage
    when 0..60
      "green"
    when 61..84
      "yellow"
    when 85..100
      "red"
    end 
  end

  def vacancy(total_students)
    if (total_students == 0)
      'Não há vagas disponíveis'
    elsif (total_students == 1)
      "#{total_students} vaga disponível"
    else 
      "#{total_students} vagas disponíveis"
    end 
  end 
end
