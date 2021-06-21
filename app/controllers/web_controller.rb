class WebController < ApplicationController
  before_action :check_params, only: :shortern
  before_action :set_url, only: :redirect
  before_action :add_log, only: :redirect

  def shortern
    @url = Url.create(orginalURL: params[:redirect_url])
    render json: result_json, status: :ok and return if @url.save
    render :json => { :errors => @url.errors.full_messages }, status: :unprocessable_entity
  end

  def redirect
    redirect_to @url.orginalURL
  end

  private

  def set_url
    render json: missing_params, status: :unprocessable_entity and return unless params[:key]
    @url = Url.find_by(key: params[:key])
    render status: :not_found and return unless @url
  end

  def add_log
    UrlLog.create(url_id: @url.id, redirection_time: DateTime.now)
  end

  def check_params
    render json: missing_params, status: :unprocessable_entity and return unless params[:redirect_url]
  end

  def result_json
    { key: @url.key, shortern_url: "#{request.protocol}#{request.host_with_port}/#{@url.key}"}
  end
end