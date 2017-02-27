class MakeReportJob < ApplicationJob
  queue_as :default

  def perform(params)
    start_date = params[:start_date].to_time
    end_date   = params[:end_date].to_time

    report = User.left_joins(:posts,:comments).
      select("users.*, COUNT(DISTINCT posts.id) AS posts_count, COUNT(DISTINCT comments.id) AS comments_count").
      where(posts:    { published_at: start_date..end_date },
            comments: { published_at: start_date..end_date }).
      group("users.id").
      order('(COUNT(posts.id)+COUNT(comments.id))/10')

    SendMailer.mail_send(params[:email], start_date, end_date, report).deliver_now

  end
end
