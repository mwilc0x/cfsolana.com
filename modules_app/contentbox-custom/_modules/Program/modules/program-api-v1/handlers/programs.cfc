/**
 * RESTFul CRUD for Programs
 * Only tokens with the `AUTHOR_ADMIN` can interact with this endpoint
 */
component extends="contentbox-api-v1.handlers.baseHandler" secured="AUTHOR_ADMIN" {

	// DI
	property name="ormService" inject="ProgramService@program";

	// The default sorting order string: name, etc.
	variables.sortOrder = "name";
	// The name of the entity this resource handler controls. Singular name please.
	variables.entity = "Program";
	// Use getOrFail() for show/delete/update actions
	variables.useGetOrFail = true;

	/*
	|--------------------------------------------------------------------------
 	| CRUD Functions
	|--------------------------------------------------------------------------
	*/

	/**
	 * Display all programs according to query options
	 *
	 * @tags Programs
	 * @x    -contentbox-permissions AUTHOR_ADMIN
	 */
	function index( event, rc, prc ){

		// criterias and filters
		param rc.sortOrder = "name";
		param rc.search = "";
		param rc.isActive = true;
		param rc.page = 1;

		// make sure isActive is boolean
		if ( !isBoolean( rc.isActive ) ) {
			rc.isActive = true;
		}

		// build up a search criteria and let the base execute it
		arguments.results = variables.ormService.search(
			searchTerm = rc.search,
			isActive = rc.isActive,
			offset = getPageOffset( rc.page ),
			max = getMaxRows(),
			sortOrder = rc.sortOrder
		);

		// build to match interface
		arguments.results.records = arguments.results.programs;

		// delegate it!
		super.index( argumentCollection = arguments );
	}

	/**
	 * Show a program using the id
	 *
	 * @tags Programs
	 * @x    -contentbox-permissions AUTHOR_ADMIN
	 */
	function show( event, rc, prc ){
		param rc.includes = "";
		param rc.excludes = "";
		param rc.ignoreDefaults = false;
		param rc.id = 0;
		
		super.show( argumentCollection = arguments );
	}

	/**
	 * Create an program in ContentBox
	 *
	 * @tags Programs
	 * @x    -contentbox-permissions AUTHOR_ADMIN
	 */
	function create( event, rc, prc ){

		arguments.saveMethod = "save";
		super.create( argumentCollection = arguments );

	}

	/**
	 * Update an existing program
	 *
	 * @tags Programs
	 * @x    -contentbox-permissions AUTHOR_ADMIN
	 */
	function update( event, rc, prc ){

		// can't update everything via the API
		arguments.populate.exclude = "";
		arguments.populate.nullEmptyInclude = "";

		super.update( argumentCollection = arguments );

	}

	/**
	 * Delete an program using an id
	 *
	 * @tags Programs
	 * @x    -contentbox-permissions AUTHOR_ADMIN
	 */
	function delete( event, rc, prc ){

		super.delete( argumentCollection = arguments );

	}

}
