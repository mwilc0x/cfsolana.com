<cfoutput>
	<div class="panel panel-primary">
		<!--- Info Box --->
		<div class="panel-heading">
			<h3 class="panel-title">
				<i class="fa fa-cogs"></i> Actions
			</h3>
		</div>
		<div class="panel-body">
			<button class="btn btn-danger" style="margin-right: 5px" onclick="return to('#event.buildLink( prc.xehPrograms )#' )">Programs</button>
			<button class="btn" onclick="return to('#event.buildLink( prc.xehProgramSettings )#' )" title="Set global program settings">Settings</button>
		</div>
	</div>
</cfoutput>