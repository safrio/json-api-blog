class SendMailer < ApplicationMailer
  def mail_send(to_email, date1, date2, report)
    @report = report
    @start_date = date1
    @end_date   = date2

    mail to: to_email, subject: "Report from #{@start_date} to #{@end_date}"
  end
end
