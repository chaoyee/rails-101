class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]

  def index
    # flash[:success] = "早安！您好！"
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts
  end

  def edit
    @group = current_user.groups.find(params[:id])
  end

  def create
    @group = current_user.groups.create(group_params)

    if @group.save
      current_user.join!(@group)
      redirect_to groups_path, notice: "新增討論版成功！"
    else
      render :new
    end
  end

  def update
    @group = current_user.groups.find(params[:id])

    if @group.update(group_params)
      redirect_to groups_path, notice: "修改討論版成功"
    else
      render :edit
    end
  end

  def destroy
    @group = current_user.groups.find(params[:id])
    @group.destroy
    redirect_to groups_path, alert: "討論版已經刪除！"
  end


  def join
    @group = Group.find(params[:id])

    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
      flash[:notice] = "您已經成功加入本討論版"
    else
      flash[:warning] = "您已經是討論版成員了"
    end

    redirect_to groups_path(@group)
  end

  def quit
    @group = Group.find(params[:id])

    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
      flash[:notice] = "您已經成功退出本討論版"
    else
      flash[:warning] = "您不是本討論版成員，無法退出。"
    end

    redirect_to groups_path(@group)
  end

  private

  def group_params
    params.require(:group).permit(:title, :description)
  end

end
