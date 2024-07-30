document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.group-link').forEach(link => {
    link.addEventListener('click', function(event) {
      event.preventDefault();
      const url = this.getAttribute('href');

      fetch(url, {
        headers: {
          'X-Requested-With': 'XMLHttpRequest'
        }
      })
      .then(response => response.text())
      .then(html => {
        document.getElementById('center_container').innerHTML = html;
      })
      .catch(error => console.error('Error fetching expenses:', error));
    });
  });
});