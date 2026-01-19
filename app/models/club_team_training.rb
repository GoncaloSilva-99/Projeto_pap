class ClubTeamTraining < ApplicationRecord
  belongs_to :club_locker_room
  belongs_to :club_pitch
  belongs_to :club_team

  validates :pitch_zone, presence: true
  validate :no_zone_overlap_on_pitch

  private

  def times_overlap_with?(other_training)
    t1_start = start_time.hour * 60 + start_time.min
    t1_end = end_time.hour * 60 + end_time.min
    t2_start = other_training.start_time.hour * 60 + other_training.start_time.min
    t2_end = other_training.end_time.hour * 60 + other_training.end_time.min
    t1_start < t2_end and t2_start < t1_end
  end

  def zones_conflict?(zone1, zone2)
    return true if zone1.include?("Zona A") or zone2.include?("Zona A")
    return true if zone1 == zone2
    if zone1.include?("Zona B") and (zone2.include?("Zona D") or zone2.include?("Zona E"))
      return true
    end
    if zone2.include?("Zona B") and (zone1.include?("Zona D") or zone1.include?("Zona E"))
      return true
    end
    if zone1.include?("Zona C") and (zone2.include?("Zona F") or zone2.include?("Zona G"))
      return true
    end
    if zone2.include?("Zona C") and (zone1.include?("Zona F") or zone1.include?("Zona G"))
      return true
    end

    false
  end

  def no_zone_overlap_on_pitch
      overlapping = ClubTeamTraining.where(club_pitch_id: club_pitch_id).where.not(id: id)
      
      if recurring
        overlapping = overlapping.where(recurring: true, weekday: start_time.wday)
      else
        overlapping = overlapping.where("recurring = ? OR (recurring = ? AND weekday = ? AND start_time >= ? AND start_time <= ?)", false, true, start_time.wday, start_time.beginning_of_day, start_time.end_of_day)
      end

      overlapping.each do |training|
        if times_overlap_with?(training) and zones_conflict?(pitch_zone, training.pitch_zone)
          @selected_sport = params[:sport]
          @selected_pitch = params[:pitch]
          if params[:ct]
            @selected_ct = params[:ct]
            redirect_to redirect_to club_infrastructures_dashboard_path(sport: @selected_sport, pitch: @selected_pitch, ct: @selected_ct), alert: "Treino não pode ser criado! Existe uma sobreposição de treinos na zona selecionada"
          end
          redirect_to redirect_to club_infrastructures_dashboard_path(sport: @selected_sport, pitch: @selected_pitch), alert: "Treino não pode ser criado! Existe uma sobreposição de treinos na zona selecionada"
          return
        end
      end
  end

end
