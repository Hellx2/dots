require("neo-tree").setup({
	close_if_last_window = true,
	default_component_configs = {
		file_size = {
			enabled = false,
		},
		type = {
			enabled = true,
			required_width = 20,
		},
	},
})
require("neo-tree.command").execute({ action = "show", toggle = true })
