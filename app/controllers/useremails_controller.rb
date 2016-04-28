class UseremailsController < ApplicationController
  before_action :set_useremail, only: [:show, :edit, :update, :destroy]

  # GET /useremails
  # GET /useremails.json
  def index
    @useremails = Useremail.all
  end

  # GET /useremails/1
  # GET /useremails/1.json
  def show
  end

  # GET /useremails/new
  def new
    @useremail = Useremail.new
  end

  # GET /useremails/1/edit
  def edit
  end

  # POST /useremails
  # POST /useremails.json
  def create
    @useremail = Useremail.new(useremail_params)

    respond_to do |format|
      if @useremail.save
        format.html { redirect_to @useremail, notice: 'Useremail was successfully created.' }
        format.json { render action: 'show', status: :created, location: @useremail }
      else
        format.html { render action: 'new' }
        format.json { render json: @useremail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /useremails/1
  # PATCH/PUT /useremails/1.json
  def update
    respond_to do |format|
      if @useremail.update(useremail_params)
        format.html { redirect_to @useremail, notice: 'Useremail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @useremail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /useremails/1
  # DELETE /useremails/1.json
  def destroy
    @useremail.destroy
    respond_to do |format|
      format.html { redirect_to useremails_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_useremail
      @useremail = Useremail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def useremail_params
      params.require(:useremail).permit(:name, :email, :login)
    end
end
