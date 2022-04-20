class LinksController < ApplicationController
  before_action :find_link, only: [:show, :update, :destroy]
  def index
    # TODO: serilize this response
    # links = Link.find(&:active)
    links = Link.all.select(&:active)
    render json: links, status: 200
  end

  def create
    link = Link.new(link_param)
    if link.save
      render json: link, status: 201
    else
      message = {
        'message': "Something went wrong with creating this link #{params["link"]["display_text"]}",
        'details': link.errors.messages
      }
      render json: message, status: 400
    end
  end

  def destroy 
    if @link
      @link.update(active: false)
      render json: { message: 'Link successfully deleted.'}, status:200
    else
      render json: { error: "Unable to delete link => #{@link}"}, status:400
    end
  end

  private

  def link_param
    params.require(:link).permit(:display_text, :url)
  end

  def find_link
    @link = Link.find_by_id(params[:id])
  end
end
