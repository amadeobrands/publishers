class YoutubeChannelDetails < ApplicationRecord
  has_paper_trail

  has_one :channel, as: :details

  validate :youtube_channel_not_changed_once_initialized
  validates :youtube_channel_id, presence: true, uniqueness: true
  validates :title, presence: true
  validates :thumbnail_url, presence: true
  validates :auth_user_id, presence: true

  def channel_identifier
    "youtube#channel:#{youtube_channel_id}"
  end

  def publication_title
    title
  end

  private

  # verification to ensure youtube_channel is not changed
  def youtube_channel_not_changed_once_initialized
    return if youtube_channel_id_was.nil?

    if youtube_channel_id_was != youtube_channel_id
      errors.add(:youtube_channel_id, "can not change once initialized")
    end
  end
end