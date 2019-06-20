class ToppagesController < ApplicationController
  def index
    if logged_in?
      # logged_in?という関数はログインしているかどうかをチェックしている
      # これがtrueであるならば、この中身が実行される。
      # SessionsHelperの中で定義されており、ApplicationControllerでそれをMix-inしている。
      # ToppagesControllerをはじめ、全てのController内でApplicationControllerを継承しているので、
      # 結局logged_in?は全てのControllerの中で用いることが可能。
      @task = current_user.tasks.build  # form_for用
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
    end
    # 全てのControllerのGETのActionは、各々自分に対応するviewを所有している。
    # それは app/views/controller名/action名.html.erb で定義されている
    # 今回の場合は、app/views/toppages/index.html.erb がそれに当たる
  end
end
