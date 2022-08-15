/**
 * ContentBox - A Modular Content Platform
 * Copyright since 2012 by Ortus Solutions, Corp
 * www.ortussolutions.com/products/contentbox
 * ---
 * Manage program settings
 */
component extends = "base" {

	/*
	|--------------------------------------------------------------------------
 	| CRUD Functions
	|--------------------------------------------------------------------------
	*/

	/**
	 * Settings management
	 */
	function index( event, rc, prc ){

		// settings view
		event.setView( "settings/index" );

	}

}
