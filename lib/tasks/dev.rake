# frozen_string_literal: true

namespace :dev do
  DEFAULT_ADMIN_PASSWORD = 'admin@123'
  DEFAULT_USER_PASSWORD = 'user@123'

  desc 'TODO'
  task setup: :environment do
    if Rails.env.development?
      show_spinner('Apagando BD...') { `rails db:drop:_unsafe` }
      show_spinner('Criando BD...') { `rails db:create` }
      show_spinner('Migrando BD...') { `rails db:migrate` }
      show_spinner('Cadastrando administrador padrão...') { `rails dev:add_default_superadmin` }
      show_spinner('Cadastrando usuário padrão...') { `rails dev:add_default_user` }
      show_spinner('Adicionando dias da semana...') { `rails dev:add_week_days` }
      show_spinner('Executando seeds...') { `rails db:seed` }
      show_spinner('Adicionando eventos...') { `rails dev:add_events` }
    else
      puts 'Você não está em ambiente de desenvolvimento.'
    end
  end

  desc 'Adiciona um superadministrador padrão'
  task add_default_superadmin: :environment do
    User.create!(
      full_name: 'Admin',
      email: 'admin@admin.com',
      password: DEFAULT_ADMIN_PASSWORD,
      password_confirmation: DEFAULT_ADMIN_PASSWORD,
      role: 2
    )
  end

  desc 'Adiciona um usuário padrão'
  task add_default_user: :environment do
    User.create!(
      full_name: 'User',
      email: 'user@user.com',
      password: DEFAULT_USER_PASSWORD,
      password_confirmation: DEFAULT_USER_PASSWORD,
      role: 0
    )
  end

  desc 'Adiciona eventos'
  task add_events: :environment do
    # ccnsm = Location.create(
    #   description: 'Centro Comunitário Nossa Senhora Medianeira',
    #   address: 'Rua Clarindo de Queiroz, 2018'
    # )
    40.times do
      Event.create(
        title: Faker::Lorem.paragraph_by_chars(number: 100, supplemental: true),
        location: Location.first,
        scheduled_for: Time.now,
        starts_at: Time.now,
        ends_at: Time.now + 4.hours,
        description: Faker::Lorem.paragraph_by_chars(number: 255, supplemental: true)
      )
    end
  end

  desc 'Adiciona dias da semana'
  task add_week_days: :environment do
    I18n.t(:"date.day_names").each do |day|
      WeekDay.create(description: day.remove('-feira'))
    end
  end

  private

  def show_spinner(msg_start, msg_end = 'Concluído!')
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success(msg_end.to_s)
  end
end
