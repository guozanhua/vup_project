/// @function instance_is_object(id,parent)
/// @arg id
/// @arg parent/[]
function instance_is_object(ind, par) {
	if(!instance_exists(ind))
		return false;
	else{
		if(is_array(par)){
			for(var i=0;i<array_length(par);i++){
				if(object_exists(par[i])
				&&(object_is_ancestor(ind.object_index,par[i])
				|| ind.object_index==par[i])){
					return true;
				}
			}
			return false;
		}
		else{
			if(object_exists(par)
			&&(object_is_ancestor(ind.object_index,par)
			|| ind.object_index==par))
				return true;
			else
				return false;
		}
	}
}
