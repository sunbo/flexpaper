class UserDocsController < ApplicationController

  before_filter :login_required , :except => [:index]
  before_filter :check_administrator_role, :except => [:index]
  
  def index
    if logged_in?
        @departments = Department.all
        if params[:id].present?
          @user_doc = UserDoc.find params[:id]
          @swf = @user_doc.simple_path
        else
          @swf = "/flexpaper/xxg.swf"
        end
    else
     redirect_to login_path
    end
  end
  
  def new
    get_user
    @user_doc = UserDoc.new
  end

  def create
     get_user

     UserDoc.transaction do
        @user_doc = UserDoc.create(params[:user_doc])

        if @user_doc.errors.blank?
          system "/usr/local/swftools/bin/pdf2swf \"public/doc/#{@user_doc.doc_file_name}\" -o \"public/doc/#{@user_doc.user.login}.swf\" -T 9 -f "
          #windowns测试改用下面一条,如果报错删除后边的  -T 9 -f 再试下，我没有在windowns下测试过
          #system "c:/pdf2swf.exe \"public/doc/#{@user_doc.doc_file_name}\" -o \"public/doc/#{@user_doc.user.login}.swf\" -T 9 -f "
          flash[:notice] = '文件上传成功'
          redirect_to new_user_doc_path
        else
          render :action => 'new'
        end
     end

   end

   def destroy
      UserDoc.transaction do
       @user_doc = UserDoc.find params[:id]
       if @user_doc.destroy
         system "rm -rf \"public/doc/#{@user_doc.user.login}.swf\" "
         flash[:notice] = '文件删除成功'
         redirect_to new_user_doc_path
       end
      end
   end

   protected
   
   def get_user
      @have_doc_users = UserDoc.all
      user = []
      @have_doc_users.each do |user_doc|
        user << user_doc.user_id
      end
      if user.blank?
         @users = User.find(:all,:conditions => ["login != 'admin' "])
      else
        @users = User.find(:all,:conditions => ["login != 'admin' and id not in (#{user.join(',').to_s})"])
      end
   end
end
