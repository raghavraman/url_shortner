class WebController < ApplicationController
  before_action :check_params, only: :shortern
  before_action :set_url, only: [:redirect, :delete]
  before_action :check_deletion, only: [:redirect, :delete]
  before_action :check_expiration, only: :redirect
  before_action :add_log, only: :redirect

  def shortern
    @url = Url.create(
      orginalURL: params[:redirect_url],
      expiration: Date.strptime(params[:expiration], '%m/%d/%Y')
    )
    render json: result_json, status: :ok and return if @url.save
    render :json => { :errors => @url.errors.full_messages }, status: :unprocessable_entity
  end

  def redirect
    redirect_to @url.orginalURL
  end

  def delete
    @url.is_deleted = true
    render json: {success: "Successfully deleted"}, status: :ok and return if @url.save
  end

  private

  def set_url
    render json: missing_params, status: :unprocessable_entity and return unless params[:key]
    @url = Url.find_by(key: params[:key])
    render json: { error: 'not found'}, status: :not_found and return unless @url
  end

  def check_expiration
    render json: { error: 'url expired'}, status: :not_found and return if DateTime.current.to_date > @url.expiration
  end

  def check_deletion
    render json: { error: 'url already deleted'}, status: :not_found and return if @url.is_deleted
  end

  def add_log
    UrlLog.create(url_id: @url.id, redirection_time: DateTime.now)
  end

  def check_params
    render json: missing_params, status: :unprocessable_entity and return unless params[:redirect_url]
    render json: {error: "Expiration date is old"}, status: :unprocessable_entity and return if Date.strptime(params[:expiration], '%m/%d/%Y') < DateTime.current.to_date
  rescue ArgumentError => e
    render :json => { :errors => 'date Format for expiration not accepted' }, status: :unprocessable_entity and return
  end

  def result_json
    { key: @url.key, shortern_url: "#{request.protocol}#{request.host_with_port}/#{@url.key}"}
  end
end