/**
 * Solana API Service Wrapper
 * ---
 * This service wrapper leverages the JSON-RPC API from Solana.
 */
component {

	// Module Properties
	this.title = "solana";
	this.author = "Ortus Solutions";
	this.webURL = "https://www.ortussolutions.com";
	this.description = "Solana API Service Wrapper";
	this.modelNamespace = "solana";
	this.cfmapping = "solana";
	this.entryPoint = "solana";

	variables.SETTING_DEFAULTS = {
		API_URL: "https://api.devnet.solana.com"
	};

	/**
	 * Configure Module
	 */
	function configure(){
		// Solana Settings
		settings = structCopy( variables.SETTING_DEFAULTS );
	}

	/**
	 * Fired when the module is registered and activated.
	 */
	function onLoad(){
		binder.map( "solana@solanacfc" )
			.to( "#moduleMapping#.solana" )
			.asSingleton()
			.initWith(
				apiURL = settings.API_URL
			);
		binder.mapDirectory(
			packagePath = "#moduleMapping#/models",
			namespace = "@solanacfc"
		);	
	}

	/**
	 * Fired when the module is unregistered and unloaded
	 */
	function onUnload(){
	}

}