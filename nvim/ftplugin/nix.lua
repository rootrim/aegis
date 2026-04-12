local lsp = require('user.lsp')
lsp.enable_and_config('nixd', {
	cmd = { 'nixd', '--semantic-tokens=true' },
	settings = {
		nixd = {
			nixpkgs = {
				expr = 'import <nixpkgs> { }',
			},
			formatting = {
				command = { 'alejandra' },
			},
			options = {
				nixos = {
					expr = '(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.zenith.options',
				},
				home_manager = {
					expr = '(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.zenith.options.home-manager.users.type.getSubOptions []',
				},
				flake_parts = {
					expr = '(builtins.getFlake (builtins.toString ./.)).debug.options',
				},
				flake_parts2 = {
					expr = '(builtins.getFlake (builtins.toString ./.)).currentSystem.options',
				},
			},
		},
	},
})
