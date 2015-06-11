module StaticPagesHelper
	def current_page(name, controller)
		@controller_action = controller.action_name

		if name == @controller_action
			"active"
		else
			nil.to_s
		end
	end
end
