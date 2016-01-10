class Account < ActiveRecord::Base
  # double-entry book-keeping design based on this article:
  # http://web.archive.org/web/20131013080026/http://homepages.tcp.co.uk/~m-wigley/gc_wp_ded.html

  has_many :postings

  ## TODO: cache on updates to postings
  def balance
    postings.sum(:amount)
  end
end
