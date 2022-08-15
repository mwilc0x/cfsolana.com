<cfoutput>
	#renderView( "viewlets/assets" )#

	<div class="row">
		<div class="col-md-12">
			<h1 class="h1">
				<i class="fas fa-box-open"></i> Programs
			</h1>
		</div>
	</div>
	<div class="row">
		<div class="col-md-9">
			<div class="panel panel-default">
				<div class="panel-body">
					#getInstance( "MessageBox@cbmessagebox" ).renderit()#

					#html.startForm( name = "programsForm", action = prc.xehProgramRemove )#
					#html.hiddenField( name = "programID", value = "" )#

					<!--- filter bar --->
					<div class="well well-sm">
						<div class="btn-group btn-sm pull-right">
							<button class="btn btn-sm btn-primary" onclick="return to('#event.buildLink( prc.xehProgramCreate )#')" title="Create new program">Create Program</button>
						</div>
						
						<div class="form-group form-inline no-margin">
							<input type="text" name="programsFilter" size="30" class="form-control" placeholder="Quick Filter" id="programsFilter">
						</div>
					</div>

					<!--- programs --->
					<table name="programs" id="programs" class="tablesorter table table-striped" width="98%">
						<thead>
							<tr>
								<th>Program</th>
								<th>Create Date</th>
								<th>Last Modified Date</th>
								<th width="75" class="center {sorter:false}">Actions</th>
							</tr>
						</thead>
						<tbody>
							<cfloop array="#prc.programs#" index="program">
								<tr>
									<td>
										<a href="#event.buildLink(prc.xehProgramUpdate)#/programID/#program.getProgramID()#" title="Edit #program.getName()#">#program.getName()#</a>
									</td>
									<td>#dateFormat( program.getCreatedDate(), "short" )# #timeFormat( program.getCreatedDate(), "short" )#</td>
									<td>#dateFormat( program.getModifiedDate(), "short" )# #timeFormat( program.getModifiedDate(), "short" )#</td>
									<td class="center">
										<!--- Edit Command --->
										<a href="#event.buildLink(prc.xehProgramUpdate)#/programID/#program.getProgramID()#" title="Edit #program.getName()#"><i class="fa fa-edit"></i></a>
										<!--- Delete Command --->
										<a title="Delete Program" href="javascript:removeProgram('#program.getProgramID()#')" class="confirmIt textRed" data-title="Delete Program?"><i id="delete_#program.getProgramID()#" class="fa fa-trash"></i></a>
									</td>
								</tr>
							</cfloop>
						</tbody>
					</table>
					#html.endForm()#

				</div>
			</div>
		</div>

		<!--- sidebar --->
		<div class="col-md-3">
			<cfinclude template="../sidebar/actions.cfm" >
			<cfinclude template="../sidebar/help.cfm" >
		</div>
	</div>
</cfoutput>