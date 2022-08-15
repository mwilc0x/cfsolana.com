/**
 * ContentBox - A Modular Content Platform
 * Copyright since 2012 by Ortus Solutions, Corp
 * www.ortussolutions.com/products/contentbox
 * ---
 * I am a Program entity
 */
component
		persistent="true"
		entityname="program"
		table="pgm_programs"
		batchsize="25"
		extends="contentbox.models.BaseEntity"
		cachename="program"
		cacheuse="read-write"
	{

	/*
	|--------------------------------------------------------------------------
	| Dependency Injection
	|--------------------------------------------------------------------------
	*/


	/*
	|--------------------------------------------------------------------------
	| Properties
	|--------------------------------------------------------------------------
	*/

	property name="programID" column="programID" fieldtype="id" generator="uuid" length="36" ormtype="string" update="false";
	property name="name" column="name" length="100" notnull="true" default="" index="idx_name";
	property name="description" column="description" length="1000" default="";

	/*
	|--------------------------------------------------------------------------
	| Relationships
	|--------------------------------------------------------------------------
	*/

	/*
	|--------------------------------------------------------------------------
	| Calculated Fields
	|--------------------------------------------------------------------------
	*/

	/*
	|--------------------------------------------------------------------------
	| Non-Persisted Properties
	|--------------------------------------------------------------------------
	*/

	/*
	|--------------------------------------------------------------------------
	| Constraints + Memento
	|--------------------------------------------------------------------------
	*/

	this.pk = "programID";

	this.memento = {
		// Default properties to serialize
		defaultIncludes : [
			"programID",
			"name",
			"description",
			"isDeleted",
			"createdDate",
			"modifiedDate"
		],

		// Default Exclusions
		defaultExcludes : [	],
		neverInclude : [ ],

		// Defaults
		defaults : {  }
	};

	this.constraints = {
		"name" : { required : true, size : "1..100" },
		"description" : { required : false, size : "1..1000" }
	};

	/*
	|--------------------------------------------------------------------------
	| Public Functions
	|--------------------------------------------------------------------------
	*/

	/**
	 * Constructor
	 */
	function init(){
		variables.isActive = true;

		super.init();

		return this;
	}

	/**
	* Has this program been loaded?
	*/
	boolean function isLoaded(){
		return len( getProgramID() );
	}


	/*
	|--------------------------------------------------------------------------
	| Private/Helper Functions
	|--------------------------------------------------------------------------
	*/

}
