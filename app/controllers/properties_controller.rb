class PropertiesController < ApplicationController
  before_action :set_property, only: %i[show edit update destroy]

  def index
    @properties = Property.all
    render json: @properties.to_json(only: %i[id name property_type city country])
  end

  def show
    render json: @property
  end

  def create
    @property = Property.create!(property_params)
    json_response(@property, :created)
  end

  def update
    @property.update(property_params)
    json_response(@property, :accepted)
  end

  def destroy
    @property.destroy
    json_response(@property, :accepted)
  end

  private

  def set_property
    @property = Property.find(params[:id])
  end

  def property_params
    params.permit(:name, :property_type, :street, :external_number, :internal_number, :neighborhood, :city, :country, :rooms, :bathrooms, :comments)
  end
end
