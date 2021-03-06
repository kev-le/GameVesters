class LeaderboardsController < ApplicationController
  before_action :logged_in_user, only: [:show, :show_net_worth]

  def show
    @leaders = sort_by_percent_increase
    @first = @leaders[0]
    @second = @leaders[1]
    @third = @leaders[2]

    @ranking_index = 3
    @name_index = 1
    @rank_value_index = 2
    @user_id_index = 0

    rank_leaders_after_third
  end

  def show_net_worth
    @leaders = sort_by_net_worth
    @first = @leaders[0]
    @second = @leaders[1]
    @third = @leaders[2]

    @ranking_index = 3
    @name_index = 1
    @rank_value_index = 2
    @user_id_index = 0

    rank_leaders_after_third
  end

  private

  def sort_by_percent_increase
    sorted_by_percent_increase = User.order('percent_increase desc').pluck(:id, :name, :percent_increase)
  end

  def sort_by_net_worth
    sorted_by_net_worth = User.order('current_net_worth desc').pluck(:id, :name, :current_net_worth)
  end

  def rank_leaders_after_third
    rank = 4
    @leaders = @leaders[3..19]

    @leaders.each do |user|
      user.push(rank)
      rank += 1
    end
  end
end
