module Projects
  class Policy < ::Libs::Policy
    def show?(project, user_id)
      project_owner?(project, user_id)
    end

    def update?(project, user_id)
      project_owner?(project, user_id)
    end

    def destroy?(project, user_id)
      project_owner?(project, user_id)
    end

    private

    def project_owner?(project, user_id)
      project.user_id == user_id ? Success() : Failure(::Libs::Error.new(status: :forbidden))
    end
  end
end
