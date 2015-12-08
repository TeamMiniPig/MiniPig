window.onload = function() {
	var message = document.getElementsByClassName('close')[0];
	if (message) {
		message.onclick = function() {
			this.parentNode.parentNode
			.removeChild(this.parentNode);
		}
	}

	// Checkbox => parent => parent => first child => first child = input field!
	var checkBoxes = document.getElementsByClassName('enable-field-checkbox');
	console.log(checkBoxes)
	if (checkBoxes.length > 0) {
		for (var i = 0; i < checkBoxes.length; i++) {
			checkBoxes[i].onclick = function() {
				var input = this.parentNode.parentNode.childNodes[1].childNodes[1];
				if (this.checked) {
					input.disabled = false;
					console.log(input)
					input.focus();
				}
				else {
					input.value = '';
					input.disabled = true;
				}
			}
		}
	}
}
