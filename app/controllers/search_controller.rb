class SearchController < ApplicationController

  def index
    @query = params[:query]

    if current_user.admin?
      @web_accounts = WebAccount.where(:title => Regexp.new(@query))
      @generic_accounts = GenericAccount.where(:title => Regexp.new(@query))
      @licenses = SoftwareLicense.where(:title => Regexp.new(@query))
      @notes = Note.where(:title => Regexp.new(@query))
    else
      @web_accounts = WebAccount.any_of({ :group_ids.in => current_user.group_ids }, { :group_ids => [] }).where(:title => Regexp.new(@query))
      @generic_accounts = GenericAccount.any_of({ :group_ids.in => current_user.group_ids }, { :group_ids => [] }).where(:title => Regexp.new(@query))
      @licenses = SoftwareLicense.any_of({ :group_ids.in => current_user.group_ids }, { :group_ids => [] }).where(:title => Regexp.new(@query))
      @notes = Note.any_of({ :group_ids.in => current_user.group_ids }, { :group_ids => [] }).where(:title => Regexp.new(@query))
    end
  end
end
