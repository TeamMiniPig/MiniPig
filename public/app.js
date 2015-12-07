window.onload = function() {
	var message = document.getElementsByClassName('close')[0];
	if (message) {
		message.onclick = function() {
			this.parentNode.parentNode
			.removeChild(this.parentNode);
		}
	}
	var passwordCheckBox = document.getElementById('enable-password');
	if (passwordCheckBox) {
		var passwordInput = document.getElementById('password-input');
		passwordCheckBox.onclick = function() {
			if (this.checked) {
				passwordInput.disabled = false;
				passwordInput.focus();
			}
			else {
				passwordInput.value = '';
				passwordInput.disabled = true;
			}
		}
	}
}
