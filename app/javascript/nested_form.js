document.addEventListener('turbolinks:load', () => {
  document.querySelectorAll('.add_fields').forEach(button => {
    button.addEventListener('click', event => {
      event.preventDefault();
      const time = new Date().getTime();
      const linkId = button.getAttribute('data-id');
      const regexp = new RegExp(linkId, 'g');
      const fields = button.getAttribute('data-fields').replace(regexp, time);
      button.insertAdjacentHTML('beforebegin', fields);
    });
  });

  document.addEventListener('click', event => {
    if (event.target.matches('.remove_fields')) {
      event.preventDefault();
      const fieldParent = event.target.closest('.nested-fields');
      fieldParent.querySelector('input[name*="_destroy"]').value = '1';
      fieldParent.style.display = 'none';
    }
  });
});
