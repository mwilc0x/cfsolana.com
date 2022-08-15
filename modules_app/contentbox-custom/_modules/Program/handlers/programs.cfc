/**
 * ContentBox - A Modular Content Platform
 * Copyright since 2012 by Ortus Solutions, Corp
 * www.ortussolutions.com/products/contentbox
 * ---
 * Manage programs
 */
component extends = "base" {

	/*
	|--------------------------------------------------------------------------
 	| CRUD Functions
	|--------------------------------------------------------------------------
	*/

	/**
	 * List all programs
	 */
	function index( event, rc, prc ){

		// get the current programs
		prc.programs = programService.list( sortOrder="name DESC", asQuery=false );

		// program list view
		event.setView( "programs/index" );

	}

	/**
	 * Create a new program
	 */
	function create( event, rc, prc ){

		// exit handlers 
		prc.xehProgramSave = "#prc.modulePath#.programs.save";

		// grab a new form entity
		prc.program = programService.new();

		// editor
		prc.tabForms_editor = true;

		// program editor view
		event.setView( "programs/editor" );

	}

	/**
	 * Update an existing program
	 */
	function update( event, rc, prc ){

		// exit handlers 
		prc.xehProgramSave = "#prc.modulePath#.programs.save";

		// grab the form entity
		prc.program = programService.get( id = rc.programID );

		// editor
		prc.tabForms_editor = true;

		// program editor view
		event.setView( "programs/editor" );

	}


	/**
	 * Save changes to a program
	 */
	function save( event, rc, prc ){

		// get it and populate it
		if( structKeyExists( rc, "programID" ) && len( rc.programID ) ) {
			var program = populateModel( programService.get( rc.programID ) );
		}
		else {
			structDelete( rc, "programID" );
			var program = populateModel( programService.new() );
		}

		// validate program and get validation results object
		prc.validationResults = validate( program );

		// check for errors
		if( prc.validationResults.hasErrors() ) {
			flash.persistRC( exclude = "event" );
			getInstance( "messageBox@cbMessageBox" ).warn( messageArray = prc.validationResults.getAllErrors() );
			relocate( event = prc.xehProgramUpdate, queryString = "programID = #program.getProgramID()#" );
		}
		else {
			// save content
			programService.save( program );

			// Message
			getInstance( "messageBox@cbMessageBox" ).info( "Program saved!" );
			relocate( event = prc.xehPrograms );
		}
	}

	
	/**
	 * Remove a program
	 */
	function remove( event, rc, prc ){

		// load the form
		var program = programService.get( rc.programID );

		if( isNull( program ) ) {
			getInstance( "messageBox@cbMessageBox" ).setMessage( "warning", "Invalid program requested!" );
			relocate( prc.xehPrograms );
		}
		
		programService.delete( program );

		getInstance( "messageBox@cbMessageBox" ).info( "Program deleted!" );
		relocate( event = prc.xehPrograms );

	}

}
