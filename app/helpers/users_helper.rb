module UsersHelper
  def role_display_name(user)
    case user.role
    when "admin" then "Administrator"
    else user.role.titleize
    end
  end

  def can_create_boards_display_name(user)
    if user.can_create_board?
      "Can create boards"
    else
      "Cannot create boards"
    end
  end
end
