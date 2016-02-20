class PostsController < ApplicationController
  before_action :find_group, :authenticate_user!
  before_action :member_required, only: [:new, :create]

  def new
    @post = @group.posts.new
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.author = current_user
    @post.group = @group

    if @post.save
      redirect_to group_path(@group), notice: "新增文章成功！"
    else
      render :new
    end
  end

  def update
    @post = current_user.posts.find(params[:id])

    if @post.update(post_params)
      redirect_to group_path(@group), notice: "修改文章成功！"
    else
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])

    @post.destroy
    redirect_to group_path(@group), alert: "文章已刪除！"
  end

  private

  def find_group
    @group = Group.find(params[:group_id])
  end

  def member_required
    if !current_user.is_member_of?(@group)
      flash[:warning] = "您非此討論版成員，不能發表文章喔！"
      redirect_to group_path(@group)
    end
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
