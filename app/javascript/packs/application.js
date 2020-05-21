// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

document.addEventListener("DOMContentLoaded", () => {
  let buttons = document.getElementsByClassName('js')

  Array.from(buttons).forEach((element) => {
    element.addEventListener('click', e => {
      e.preventDefault()
      const element = e.target
      const url = element.getAttribute('href')

      fetch(url + '.json')
        .then(response => response.json())
        .then(data => {
          console.log(data)

          let text = 'Add to favourites'

          if (element.textContent == 'Add to favourites') {
            text = 'Remove from favourites'
          }

          element.textContent = text
          element.classList.toggle('on')
          element.classList.toggle('off')
        })
    })
  })
})
