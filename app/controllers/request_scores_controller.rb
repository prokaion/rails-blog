class RequestScoresController < ApplicationController
  before_action :set_request_score, only: [:show, :edit, :update, :destroy]

  # GET /request_scores
  # GET /request_scores.json
  def index
    @request_scores = RequestScore.all
  end

  # GET /request_scores/1
  # GET /request_scores/1.json
  def show
  end

  # GET /request_scores/new
  def new
    @request_score = RequestScore.new
  end

  # GET /request_scores/1/edit
  def edit
  end

  # POST /request_scores
  # POST /request_scores.json
  def create
    @request_score = RequestScore.new(request_score_params)

    respond_to do |format|
      if @request_score.save
        format.html { redirect_to @request_score, notice: 'Request score was successfully created.' }
        format.json { render :show, status: :created, location: @request_score }
      else
        format.html { render :new }
        format.json { render json: @request_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /request_scores/1
  # PATCH/PUT /request_scores/1.json
  def update
    respond_to do |format|
      if @request_score.update(request_score_params)
        format.html { redirect_to @request_score, notice: 'Request score was successfully updated.' }
        format.json { render :show, status: :ok, location: @request_score }
      else
        format.html { render :edit }
        format.json { render json: @request_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /request_scores/1
  # DELETE /request_scores/1.json
  def destroy
    @request_score.destroy
    respond_to do |format|
      format.html { redirect_to request_scores_url, notice: 'Request score was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request_score
      @request_score = RequestScore.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_score_params
      params.require(:request_score).permit(:ip, :request_count)
    end
end
