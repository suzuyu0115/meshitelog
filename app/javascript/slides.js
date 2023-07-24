var slides = document.querySelectorAll('#slideshow .slide');
var currentSlide = 0;

function changeSlide() {
  slides[currentSlide].classList.remove('active');
  currentSlide = (currentSlide + 1) % slides.length;
  slides[currentSlide].classList.add('active');
}

setInterval(changeSlide, 2000); // 2秒ごとに切り替え
