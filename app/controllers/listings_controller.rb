# frozen_string_literal: true

class ListingsController < ApplicationController
  include Pundit::Authorization
  
  before_action :set_listing, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[new create edit destroy]
  before_action :set_user

  # GET /listings or /listings.json
  def index
    @listings = Listing.all
  end

  # GET /listings/1 or /listings/1.json
  def show
    @listing = Listing.find(params[:id])
  end

  # GET /listings/new
  def new
    @listing = Listing.new
  end

  # GET /listings/1/edit
  def edit
    @listing = Listing.find(params[:id])
    authorize @listing
  end

  # POST /listings or /listings.json or /listings/new
  def create
    @listing = current_user.listings.new(listing_params)
    @user_signed_in = user_signed_in?
    respond_to do |format|
      if @listing.save
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1 or /listings/1.json
  def update
    authorize @listing
    @user_signed_in = user_signed_in?
    respond_to do |format|
      if @listing.update(listing_params)
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1 or /listings/1.json
  def destroy
    authorize @listing
    @listing.destroy

    respond_to do |format|
      format.html { redirect_to listings_url, notice: "Listing was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_listing
    @listing = Listing.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  # Only allow a list of trusted parameters through.
  def listing_params
    params.permit(:title, :address, :image_url, :price, :buy_or_rent, :description)
  end
end
