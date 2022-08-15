<cfoutput>
	<script type="text/javascript">
		document.addEventListener( "DOMContentLoaded", () => {
			// quick filter
			$("##programsFilter").keyup(function(){
				$.uiTableFilter( $("##programs"), this.value );
			});
			$("##programs").dataTable({
				"paging": false,
				"info": false,
				"searching": false,
				"columnDefs": [
				{ 
					"orderable": false, 
					"targets": '{sorter:false}' 
				}
				],
				"order": []
			});
		});
		function removeProgram(programID){
			$("##programID").val( programID );
			$("##programsForm").submit();
		}
	</script>
</cfoutput>