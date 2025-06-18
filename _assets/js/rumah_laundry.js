document.querySelectorAll('.tab-link').forEach(function(tab) {
					tab.addEventListener('click', function(e) {
						e.preventDefault();
						document.querySelectorAll('.tab-link').forEach(function(t) {
							t.classList.remove('active');
						});
						this.classList.add('active');
						const tabId = this.getAttribute('data-tab');
						document.querySelectorAll('.tab-content').forEach(function(content) {
							content.style.display = 'none';
						});
						document.getElementById('tab-' + tabId).style.display = 'block';
					});
				});