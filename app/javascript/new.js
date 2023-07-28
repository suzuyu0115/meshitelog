document.addEventListener('DOMContentLoaded', () => {
  const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  const LIFF_ID = "1661463936-EQzBJpqb";
  liff
    .init({
      liffId: LIFF_ID,
      withLoginOnExternalBrowser: true
    })
  liff
    .ready.then(() => {
      if (!liff.isLoggedIn()) {
        liff.login();
      } else {
        liff.getProfile().then(profile => {
          const idToken = liff.getIDToken()
          const name = profile.displayName
          const body = `idToken=${idToken}&name=${name}`
          const request = new Request('/user', {
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
              'X-CSRF-Token': token
            },
            method: 'POST',
            body: body
          });

          fetch(request)
            .then(response => response.json())
            .then(data => {
              data_id = data
            })
            .then(() => {
              window.location = '/posts'
            })
        })
      }
    })
})
