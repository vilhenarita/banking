defmodule Banking.EmailSender do
  require Logger

  def notify_withdraw(email, transaction) do
  Logger.info("#{email} your withdraw value: #{transaction.amount}")
  end
end
