class AscentsController < ApplicationController
  before_action :signed_in_user

  # IMPORT
  def import
      CSV.foreach(params[:file].path, headers: true) do |row|
    		Ascent.new(
          { user_id: current_user.id, 
            hill_id: Hill.find_by(number: row.field('number')).id,
            date: row.field('date')!=nil ? Date.strptime(row.field('date'), '%d/%m/%y') : nil, 
            notes: row.field('notes'),
            climbed: true }
          ).save
  		end

      hills = Hill.where(category: params[:category])
      logger.warn "Hills #{hills}"
      hills.each do |hill|
        if Ascent.find_by(user_id: current_user.id, hill_id: hill.id) == nil
          Ascent.new(
          { user_id: current_user.id, 
            hill_id: hill.id,
            date: nil, 
            notes: '',
            climbed: false }
            ).save
        end
      end
    redirect_to root_url, notice: "Ascents imported."
  end

  # DESTROY ALL
  def destroy_all
    Ascent.where(user_id: current_user).destroy_all
    redirect_to root_url, notice: "Ascents deleted."
  end

  def edit_multiple
    logger.warn params[:hill_ids]
    @hills = Hill.find(params[:hill_ids])
        respond_to do |format|
      format.html { render "hills/index" }
      format.js
    end

  end
  
  def update_multiple
    @hills = Hill.find(params[:hill_ids].split(','))
    logger.warn @hills

    @hills.each do |hill|
      ascent = hill.ascents.find_by(user_id: current_user)
      pars = {climbed: (params[:climbed]=="climbed"), date: params[:date], notes: params[:notes]}
      logger.warn pars
      if ascent.climbed
        # Hill already climbed
        if pars[:climbed] 
          # Update       
          ascent.update_attributes!(pars.reject { |k,v| v.blank? })
          logger.warn "Updated ascent #{ascent}"
        else
          # Delete
          ascent.delete()
        end
      else
        # Hill not already climbed
        if pars[:climbed]
          ascent.update_attributes!(pars.reject { |k,v| v.blank? })
          #ascent = Ascent.new(user_id: current_user.id, hill_id: hill.id,
                    #date: params[:ascent][:date], notes: params[:ascent][:notes])

          #if ascent.save
            #logger.warn "Ascent saved #{ascent}"
          #else
            #logger.warn "Ascent not saved #{ascent}"
          #end
        else
          # do nothing as no record needs to be created
        end
      end
    end
redirect_to root_url, notice: "Ascents edited."

  end


end
