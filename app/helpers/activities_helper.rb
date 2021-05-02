# frozen_string_literal: true

module ActivitiesHelper
  def find_color(percentage)
    case percentage
    when 0..60
      'green'
    when 61..84
      'yellow'
    when 85..100
      'red'
    end
  end

  def available(activity)
    activity.max_capacity - activity.students.count
  end

  def has_image(activity)
    activity.display_image.attached?
  end

  def image_filename(activity, f)
    has_image(activity) ? f.object.display_image.blob.filename.to_s : 'Nenhuma imagem selecionada'
  end

  def vacancy(total_students)
    if total_students.zero?
      'Não há vagas disponíveis'
    elsif total_students == 1
      "#{total_students} vaga disponível"
    else
      "#{total_students} vagas disponíveis"
    end
  end
end
