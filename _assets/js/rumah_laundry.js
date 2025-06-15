document.addEventListener('DOMContentLoaded', function() {
  var tabLinks = document.querySelectorAll('.tab-link');
  if(tabLinks.length > 0) {
    tabLinks.forEach(function(tab) {
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
        var tabContent = document.getElementById('tab-' + tabId);
        if(tabContent) tabContent.style.display = 'block';
      });
    });
  }
});

console.log('Hello Rumah Laundry');