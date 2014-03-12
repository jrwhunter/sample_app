class HillsController < ApplicationController


  # GET /hills
  # GET /hills.json
  def index
    @hills = Hill.all
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

  # IMPORT
  def import
    Hill.import(params[:file])
    redirect_to root_url, notice: "Hills imported."
  end

  # DESTROY ALL
  def destroy_all
    Hill.destroy_all
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hill_params
      params.require(:hill).permit(:number, :name, :other_info, :origin, :chapter, :height, :grid_ref, :map)
    end

end
