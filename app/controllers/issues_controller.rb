class IssuesController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update, :delete, :destroy]
  respond_to :html, :xml, :json

  def index
    respond_with(@issues = Issue.all)
  end

  def new
    respond_with(@issue = Issue.new)
  end


  def create
    debugger
    @pic = Pic.new(params[:issue].delete(:pics))
    @location = Location.new(params[:issue].delete(:location))
    if @pic.valid? and @location.valid?
      @issue = Issue.new(params[:issue])
      @issue.pics << @pic
      @issue.locations << @location
      @issue.user = current_user
      if @issue.save
        redirect_to show_issue_path(@issue.slug)
      else
        render :new
      end
    else
      @issue = Issue.new(params[:issue])
      @issue.valid?
      @issue.errors[:fail] = "Something went wrong"
      render :new
    end
  end


  def update
    @issue = Issue.first(:conditions => {:_id => BSON::ObjectId(params[:id])})
    @issue.update_attributes(params[:issue])
    debugger
    respond_with(@issue) do |format|
      if @issue.save
        format.json { render :json => @issue}
      end
    end
  end


  def show
    if @issue = Issue.first(:conditions => {:slug => params[:id]})
      respond_with @issue
    elsif @issue = Issue.first(:conditions => {:_id => BSON::ObjectId(params[:id])})
      redirect_to show_issue_path(@issue.slug)
    else
      raise NotFound
    end
  end

end
