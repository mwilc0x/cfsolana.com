/**
 * ContentBox - A Modular Content Platform
 * Copyright since 2012 by Ortus Solutions, Corp
 * www.ortussolutions.com/products/contentbox
 * ---
 * Service to handle program operations.
 */
component
		extends = "cborm.models.VirtualEntityService"
		accessors = "true"
		singleton
	{

	/*
	|--------------------------------------------------------------------------
	| Public Functions
	|--------------------------------------------------------------------------
	*/

	/**
	 * Constructor
	 */
	ProgramService function init(){
		super.init( entityName = "program" );
		return this;
	}

	/**
	 * Save a program
	 *
	 * @program The program object
	 *
	 * @return Program
	 */
	Program function save( required program ){
		// save the program
		return super.save( arguments.program );
	}

	/**
	 * Program search by many criteria.
	 *
	 * @searchTerm Search in name or description field
	 * @isActive Search with active bit
	 * @max The max returned objects
	 * @offset The offset for pagination
	 * @asQuery Query or objects
	 * @sortOrder The sort order to apply
	 *
	 * @return {programs:array, count:numeric}
	 */
	function search(
		string searchTerm = "",
		string isActive,
		numeric max = 0,
		numeric offset = 0,
		boolean asQuery = false,
		string sortOrder = "name,createdDate"
	){
		var results = { "count" : 0, "programs" : [] };
		var c = newCriteria();

		// search
		if ( len( arguments.searchTerm ) ) {
			c.$or(
				c.restrictions.like( "name", "%#arguments.searchTerm#%" ),
				c.restrictions.like( "description", "%#arguments.searchTerm#%" )
			);
		}

		// isActive filter
		if ( structKeyExists( arguments, "isActive" ) AND arguments.isActive NEQ "any" ) {
			c.isEq( "isDeleted", javacast( "boolean", !arguments.isActive ) );
		}

		// run criteria query and projections count
		results.count = c.count( "programID" );
		results.programs = c
			.resultTransformer( c.DISTINCT_ROOT_ENTITY )
			.list(
				offset = arguments.offset,
				max = arguments.max,
				sortOrder = arguments.sortOrder,
				asQuery = arguments.asQuery
			);

		return results;
	}

	/**
	 * Get a program by name which is active and not deleted
	 *
	 * @name The name to locate the program with
	 *
	 * @throws EntityNotFound
	 */
	Program function retrieveProgramByName( required name ){
		var program = newCriteria()
			.isEq( "name", arguments.name )
			.isFalse( "isDeleted" )
			.get();

		if ( isNull( program ) ) {
			throw(
				type = "EntityNotFound",
				message = "Program not found with name (#encodeForHTML( arguments.name )#)"
			);
		}
		return program;
	}

}