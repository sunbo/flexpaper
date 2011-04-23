class UserDoc < ActiveRecord::Base
   belongs_to :user
   
   validates_presence_of   :user_id, :message => "请选择用户"
   has_attached_file :doc,
            :url  => "/doc/:basename.:extension",
            :path => ":rails_root/public/doc/:basename.:extension"

   validates_attachment_presence :doc, :message => "请选择文件"
   validates_attachment_content_type :doc, :content_type => ['application/pdf'], :message => "文件格式只能为pdf"

   def simple_path
     path = "/doc/#{self.user.login}.swf"
   end
end
