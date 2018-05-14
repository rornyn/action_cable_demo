module ApplicationHelper
  def message_heading(message)
    (my_message?(message)) ? "right" : "left"
  end

  def message_time(message)
    distance_of_time_in_words(message.created_at, Time.now) + " ago"
  end

  def message_detail_with_html(message)
    (my_message?(message)) ?  current_user_div(message) : other_user_div(message)
  end

  private

  def my_message?(message)
    current_user == message.user
  end

  def current_user_div(message)
    "<small class='text-muted'><span class='glyphicon glyphicon-time'></span></small>
    <strong class='pull-right primary-font'>#{current_user.name}</strong>".html_safe
  end

  def other_user_div(message)
    "<strong class='primary-font'>#{message.sender_name}</strong> <small class='pull-right text-muted'>
    <span class='glyphicon glyphicon-time'></span>#{message_time(message)}</small>".html_safe
  end
end
