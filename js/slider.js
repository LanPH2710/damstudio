const slides = document.querySelector('.slides');
const totalSlides = document.querySelectorAll('.slide-wrapper').length;
let currentIndex = 0;

setInterval(() => {
  currentIndex = (currentIndex + 1) % totalSlides;
  slides.style.transform = `translateX(-${currentIndex * 100}%)`;
}, 5000); // mỗi ảnh hiển thị 5 giây
