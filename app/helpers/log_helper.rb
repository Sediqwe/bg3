module LogHelper
    def create_log(page, description)
        log = Logola.create(
          user_id: current_user.id,
          page: page,
          desc: description
        )
      log
    end
  end