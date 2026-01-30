class ClubTeamTraining < ApplicationRecord
  belongs_to :club_locker_room, optional: true
  belongs_to :club_pitch
  belongs_to :club_team

  validates :pitch_zone, presence: true

  def all_pitch?
    pitch_zone == "Zona A (Campo Inteiro)"
  end

  def half_pitch?
    pitch_zone == "Zona B (Meio Campo 1)" or pitch_zone == "Zona C (Meio Campo 2)"
  end

  def quarter_pitch?
    pitch_zone == "Zona D (Quarto de Campo 1)" or pitch_zone == "Zona E (Quarto de Campo 2)" or pitch_zone == "Zona F (Quarto de Campo 3)" or pitch_zone == "Zona G (Quarto de Campo 4)"
  end

  # Retorna o tipo de layout para a célula do calendário
  # 'full' = campo inteiro (ocupa tudo)
  # 'half' = meio campo (2 colunas)
  # 'quarter' = quarto de campo (4 colunas)
  def layout_type
    return 'full' if all_pitch?
    return 'half' if half_pitch?
    return 'quarter' if quarter_pitch?
  end

end
