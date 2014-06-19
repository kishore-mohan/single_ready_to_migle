module ApplicationHelper
	def flash_class(level)
    case level
      when :notice then "alert fade in alert-info"
      when :success then "alert fade in alert-success"
      when :error then "alert fade in alert-error"
      when :alert then "alert fade in alert-error"
    end
end
end
