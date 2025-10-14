/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


            //step 1: get DOM
            let nextDom = document.getElementById('next');
            let prevDom = document.getElementById('prev');

            let carouselDom = document.querySelector('.carousel');
            let SliderDom = carouselDom.querySelector('.carousel .list');
            let thumbnailBorderDom = document.querySelector('.carousel .thumbnail');
            let thumbnailItemsDom = thumbnailBorderDom.querySelectorAll('.item');
            let timeDom = document.querySelector('.carousel .time');

            thumbnailBorderDom.appendChild(thumbnailItemsDom[0]);
            let timeRunning = 3000;
            let timeAutoNext = 7000;

            nextDom.onclick = function () {
                showSlider('next');
            }

            prevDom.onclick = function () {
                showSlider('prev');
            }
            let runTimeOut;
            let runNextAuto = setTimeout(() => {
                next.click();
            }, timeAutoNext)
            function showSlider(type) {
                let  SliderItemsDom = SliderDom.querySelectorAll('.carousel .list .item');
                let thumbnailItemsDom = document.querySelectorAll('.carousel .thumbnail .item');

                if (type === 'next') {
                    SliderDom.appendChild(SliderItemsDom[0]);
                    thumbnailBorderDom.appendChild(thumbnailItemsDom[0]);
                    carouselDom.classList.add('next');
                } else {
                    SliderDom.prepend(SliderItemsDom[SliderItemsDom.length - 1]);
                    thumbnailBorderDom.prepend(thumbnailItemsDom[thumbnailItemsDom.length - 1]);
                    carouselDom.classList.add('prev');
                }
                clearTimeout(runTimeOut);
                runTimeOut = setTimeout(() => {
                    carouselDom.classList.remove('next');
                    carouselDom.classList.remove('prev');
                }, timeRunning);

                clearTimeout(runNextAuto);
                runNextAuto = setTimeout(() => {
                    next.click();
                }, timeAutoNext)
            }







            window.addEventListener('scroll', function () {
                const header = document.querySelector('header');
                if (window.scrollY > 10) {
                    header.classList.add('sticky');
                } else {
                    header.classList.remove('sticky');
                }
            });



            window.addEventListener('scroll', function () {
                const header = document.querySelector('header');
                if (window.scrollY > 10) {
                    header.classList.add('sticky');
                } else {
                    header.classList.remove('sticky');
                }

                // Animation for hello-frame text
                const helloContent = document.querySelector('.hello-animated-content');
                if (helloContent) {
                    const rect = helloContent.getBoundingClientRect();
                    if (rect.top < window.innerHeight - 100) {
                        helloContent.classList.add('visible');
                    }
                }
            });
            // Also trigger on page load
            window.dispatchEvent(new Event('scroll'));


            window.addEventListener('scroll', function () {
                // Sticky header logic
                const header = document.querySelector('header');
                if (window.scrollY > 10) {
                    header.classList.add('sticky');
                } else {
                    header.classList.remove('sticky');
                }

                // Animate each section's text when in view
                document.querySelectorAll('.section-animated-content').forEach(function (content) {
                    const rect = content.getBoundingClientRect();
                    if (rect.top < window.innerHeight - 100) {
                        content.classList.add('visible');
                    }
                });
            });
// Trigger on page load
            window.dispatchEvent(new Event('scroll'));


// File: app.js hoặc trong thẻ <script>

// File: app.js (hoặc trong thẻ <script>)

            document.addEventListener('DOMContentLoaded', function () {

                const menuToggleBtn = document.querySelector('.menu-toggle-btn');
                const customNavbar = document.querySelector('.custom-navbar');

                if (menuToggleBtn && customNavbar) {
                    // Khi bấm nút hamburger, nó sẽ tự động BẬT hoặc TẮT menu
                    menuToggleBtn.onclick = function () {
                        customNavbar.classList.toggle('mobile-menu-open');
                    }
                }

            });
    
    
    
    
   
