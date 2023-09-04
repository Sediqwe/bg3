module LogHelper
    def create_log(user, page, description)
      log = Logola.create(
        user_id: user.id,
        page: page,
        desc: description
      )
      log
    end
  end