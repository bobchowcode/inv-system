function addQuantity(elem) {
	$(elem).parents('form:first').attr('action', '/addQuantity');
	$(elem).parents('form:first').submit();
}

function deleteQuantity(elem) {
	$(elem).parents('form:first').attr('action', '/deleteQuantity');
	$(elem).parents('form:first').submit();
}

function editItem(elem) {
	$(elem).parents('form:first').attr('action', '/editItem');
	$(elem).parents('form:first').submit();
}