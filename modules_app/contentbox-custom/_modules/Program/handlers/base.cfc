/**
 * ContentBox - A Modular Content Platform
 * Copyright since 2012 by Ortus Solutions, Corp
 * www.ortussolutions.com/products/contentbox
 * ---
 * Base handler, designed to be extended by all module handlers
 */
component {

	// dependencies
	property name="AuthorService" inject="AuthorService@contentbox";
	property name="ProgramService" inject="entityService:Program";

	/*
	|--------------------------------------------------------------------------
	*/

	// pre handler
	function preHandler( event, action, eventArguments ) {
		var rc = event.getCollection();
		var prc = event.getCollection( private = true );

		// get module root
		prc.moduleRoot = event.getModuleRoot( "program" );

		// exit points
		prc.modulePath = "#prc.cbAdminEntryPoint#.module.program";
		prc.xehPrograms = "#prc.modulePath#.programs.index";
		prc.xehProgramCreate = "#prc.modulePath#.programs.create";
		prc.xehProgramUpdate = "#prc.modulePath#.programs.update";
		prc.xehProgramRemove = "#prc.modulePath#.programs.remove";
		prc.xehProgramSettings = "#prc.modulePath#.settings.index";

		// Get incoming author to verify credentials
		arguments.event.paramValue( "authorID", 0 );
		var oAuthor = authorService.get( rc.authorID );

		// Validate credentials only if you are an admin.
		if ( !prc.oCurrentAuthor.checkPermission( "AUTHOR_ADMIN" ) ) {
			// relocate
			cbMessagebox.error( "You do not have permissions to do this!" );
			relocate( event = prc.xehAuthors );
			return;
		}

		// use the CB admin layout
		event.setLayout( name = "admin", module = "contentbox-admin" );

		// tab control
		prc.tabModules = true;
		prc.tabModules_program = true;

	}
}