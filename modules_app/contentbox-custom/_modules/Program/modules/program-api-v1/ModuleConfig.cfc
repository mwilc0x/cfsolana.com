/**
 * ContentBox - A Modular Content Platform
 * Copyright since 2012 by Ortus Solutions, Corp
 * www.ortussolutions.com/products/contentbox
 * ---
 * Program Management API Module: version 1.x
 */
component {

	// Module Properties
	this.title = "Program Management API v1.x";
	this.author = "Ortus Solutions, Corp";
	this.webURL = "https://www.ortussolutions.com";
	this.version = "1.0";
	this.description = "Program Management API v1.x Module";

	this.entryPoint = "/pmapi/v1";
	this.modelNamespace = "program-api-v1";
	this.cfmapping = "program-api-v1";
	this.dependencies = [];

	/**
	 * Configure
	 */
	function configure(){
		// module settings - stored in modules.name.settings
		settings = {
			// Security Configuration for the API Module via cbecurity
			cbsecurity : {
				// The global invalid authentication event or URI or URL to go if an invalid authentication occurs
				"invalidAuthenticationEvent"  : "contentbox-api-v1:auth.onAuthenticationFailure",
				// Default Auhtentication Action: override or redirect when a user has not logged in
				"defaultAuthenticationAction" : "override",
				// The global invalid authorization event or URI or URL to go if an invalid authorization occurs
				"invalidAuthorizationEvent"   : "contentbox-api-v1:auth.onAuthorizationFailure",
				// Default Authorization Action: override or redirect when a user does not have enough permissions to access something
				"defaultAuthorizationAction"  : "override",
				// Global Security Rules
				"rules"                       : [
					 // {
					//	"match"      : "event",
					//	"secureList" : "program\-api\-v1\:.*", // Secure all api endpoints
					//	"whitelist"  : "(auth|echo)" // Except the auth and echo endpoints
					// }
				],
				// The validator is an object that will validate rules and annotations and provide feedback on either authentication or authorization issues.
				"validator" : "JwtSecurityValidator@contentbox"
			}
		};

		// Custom Declared Points
		interceptorSettings = { customInterceptionPoints : "" };

		// Custom Declared Interceptors
		interceptors = [];
	}

	/**
	 * Fired when the module is registered and activated.
	 */
	function onLoad(){
	}

	/**
	 * Fired when the module is unregistered and unloaded
	 */
	function onUnload(){
	}

}
