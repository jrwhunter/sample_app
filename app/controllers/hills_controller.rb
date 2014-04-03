require "csv"

class HillsController < ApplicationController


  # GET /hills
  # GET /hills.json
  def index
    if params[:category]== nil
      params[:category] = "Munros"
    end
    if signed_in? && !current_user.admin
      @ascents = Ascent.all(:include => :hill, 
          :conditions => { :ascents => { :user_id => current_user.id}, 
                        :hills => {:category => params[:category]}})
    else
       @hills = Hill.where(category: params[:category]) #where("number LIKE ?", Hill.get_pattern(params[:category]))
    end

    if @full_mates == nil
      @full_mates = []
    end
    if @part_mates == nil
      @part_mates = []
    end
    respond_to do |format|
      format.html { render "hills/index" }
      format.js
    end

  end

  # GET /hills/new
  def new
    @hill = Hill.new
  end

  # GET /hills/1/edit
  def edit
    @hill = Hill.find(params[:id])
  end

  # GET /hills/1
  # GET /hills/1.json
  def show
    @hill = Hill.find(params[:id])
  end

  # POST /hills
  # POST /hills.json
  def create
    @hill = Hill.new(hill_params)

    respond_to do |format|
      if @hill.save
        format.html { redirect_to @hill, notice: 'Hill was successfully created.' }
        format.json { render action: 'show', status: :created, location: @hill }
      else
        format.html { render action: 'new' }
        format.json { render json: @hill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hills/1
  # PATCH/PUT /hills/1.json
  def update
    @hill = Hill.find(params[:id])
    respond_to do |format|
      if @hill.update(hill_params)
        format.html { redirect_to @hill, notice: 'Hill was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @hill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE ALL
  def delete_all
  end

  # DELETE /hills/1
  # DELETE /hills/1.json
  def destroy
    Hill.find(params[:id]).destroy
    flash[:success] = "Hill deleted."
    respond_to do |format|
      format.html { redirect_to hills_url }
      format.json { head :no_content }
    end
  end

  # UPLOAD
  def upload
  end

  # IMPORT
  def import
    #Hill.import(params[:file])
    CSV.foreach(params[:file].path, headers: true) do |row|
      hash = row.to_hash
      logger.warn hash
      category = Hill.get_category(hash["number"])
      Hill.create! hash.merge({"category" => category})
      end
    redirect_to root_url, notice: "Hills imported."
  end

  # DESTROY ALL
  def destroy_all
        if params[:category] == 'Munros'
      pat = 'M___'
    elsif params[:category] == 'Munro Tops'
      pat = 'MT___'
    elsif params[:category] == 'Corbetts'
      pat = 'C___'
    elsif params[:category] == 'Grahams'
      pat = 'G___'
    elsif params[:category] == 'All'
      pat = "%"
    end

    Hill.where("number LIKE ?", pat).destroy_all
    redirect_to root_url, notice: "Hills deleted."
  end

  def get_mates
    @full_mates = []
    @part_mates = []
    if params[:hill_ids] != nil
      users = User.all
      mates = []
      #users.each do |user|
        #if !user.admin && user != current_user
          #@full_mates.push(user)
        #end
      #end
      Hill.find(params[:hill_ids]).each do |hill|
        ascent = hill.ascents.find_by(user_id: current_user)
        if !ascent.climbed          
          users.each do |user|
            if !user.admin && user != current_user
              their_ascent = hill.ascents.find_by(user_id: user.id)
              if !their_ascent.climbed 
                mates.push(user)
              #if !their_ascent.climbed && @part_mates.find_index(user) == nil
                #@part_mates.push(user)
              #elsif their_ascent.climbed && @full_mates.find_index(user) != nil
                #@full_mates.delete(user)
              end
            end
          end
        end
      end
      logger.warn "Mates #{mates}"
      logger.warn "Full mates #{@full_mates}  Part mates #{@part_mates}"

      #@full_mates.each do |full_mate|
          #@part_mates.delete(full_mate)

      users.each do |user|
        if !user.admin && user != current_user
          count = mates.count(user)
          if count == params[:hill_ids].length 
            @full_mates.push(user)
          elsif count > 0
            @part_mates.push(user)
          end
        end
      end
    end
 
    respond_to do |format|
      format.html { render "hills/index" }
      format.js
    end
  
  end


    # Never trust parameters from the scary internet, only allow the white list through.
    def hill_params
      params.require(:hill).permit(:number, :name, :other_info, :origin, :chapter, :height, :grid_ref, :map, :category)
    end


end
