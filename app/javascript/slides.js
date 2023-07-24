document.addEventListener("DOMContentLoaded", function () {
  const slides = document.querySelectorAll("#slideshow .slide");
  let currentSlide = 0;
  const slideInterval = setInterval(nextSlide, 3000); // 3秒ごとに次のスライドに移動

  function nextSlide() {
    slides[currentSlide].classList.remove('active');
    currentSlide = (currentSlide + 1) % slides.length;
    slides[currentSlide].classList.add('active');
  }
});
