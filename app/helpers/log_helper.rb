module LogHelper
    def create_log(page, description)
      if current_user.present?
        log = Logola.create(
          user_id: current_user.id,
          page: page,
          desc: description
        )      
      end

      log
    end
  end