=begin
Paperclip::Attachment.interpolations[:fake_id] = proc do |attachment, style|
  attachment.instance.created_at
end

Paperclip::Attachment.interpolations[:basename] = proc do |attachment, style|
  attachment.instance.created_at
end
=end