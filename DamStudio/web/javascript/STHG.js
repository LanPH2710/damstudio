/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


// =======================================================
// SỬA LỖI 1: Luôn bắt đầu từ đầu trang
// =======================================================
if (window.history.scrollRestoration) {
    window.history.scrollRestoration = 'manual';
}
// Chờ cho toàn bộ trang và tài nguyên được tải xong
window.onload = () => {
    // Buộc cuộn lên đầu ngay khi trang tải xong
    window.scrollTo(0, 0);

    // Vô hiệu hóa tính năng tự cuộn của trình duyệt
    if (window.history.scrollRestoration) {
        window.history.scrollRestoration = 'manual';
    }

    // Sau khi mọi thứ đã tải, chúng ta sẽ hiện nút "Bắt đầu" lên
    const startButton = document.getElementById('startButton');
    gsap.to(startButton, {
        autoAlpha: 1,
        y: 0,
        duration: 0.8,
        ease: "power2.out",
        delay: 0.5
    });

    // Lắng nghe sự kiện click vào nút "Bắt đầu"
    startButton.addEventListener('click', startExperience);
};


// HÀM CHẠY ANIMATION INTRO
function startExperience() {
    // Lấy các element cần thiết
    const loadingScreen = document.getElementById('loading-screen');
    const startButton = document.getElementById('startButton');
    const turtle = document.getElementById('turtle');
    const circles = document.querySelectorAll('.circle');
    const storyContent = document.getElementById('story-content');
    const scene1 = document.getElementById('scene-1');
    const titleText = document.querySelector('.title-text');
    const titleAudio = document.getElementById('title-audio');

    // Tạo timeline cho màn hình chờ
    const loadingTl = gsap.timeline();

    loadingTl
        .to(startButton, { autoAlpha: 0, duration: 0.3 })
        .to(turtle, { y: 150, opacity: 0, duration: 1, ease: "power2.in" }, "<")
        .to(circles, { scale: 20, opacity: 0, duration: 1.5, ease: "power3.in", stagger: 0.1, onStart: () => circles.forEach(c => c.style.animationPlayState = 'paused') }, "-=0.5")
        .to(scene1, { clipPath: 'circle(100% at 50% 50%)', duration: 1.5, ease: "power3.inOut", onStart: () => storyContent.style.visibility = 'visible' }, "<")

        // SỬA LỖI 2: Đảm bảo text của scene 1 hiện ra
        .to(titleText, { opacity: 1, duration: 1.2 }, "<0.5")

        // Phát audio cho title
        .call(() => {
            titleAudio.play();
        })

        // Sau khi intro kết thúc, dọn dẹp và BẮT ĐẦU cài đặt animation scroll
        .add(() => {
            loadingScreen.style.display = 'none';
            document.body.style.overflow = 'auto';

            // Chỉ khởi tạo animation scroll SAU KHI intro hoàn thành
            setupScrollAnimations();
        });
}



function setupScrollAnimations() {
    const scene2Audio = document.getElementById('scene2-audio');
    const scene3Audio1 = document.getElementById('scene3-audio1');
    const scene3Audio2 = document.getElementById('scene3-audio2');
    const scene4Audio = document.getElementById('scene4-audio');
    const scene5Audio = document.getElementById('scene5-audio');
    const scene6Audio = document.getElementById('scene6-audio');
    const scene7Audio = document.getElementById('scene7-audio');
    const scene8Audio = document.getElementById('scene8-audio');
    const scene9Audio = document.getElementById('scene9-audio');
    const scene10Audio = document.getElementById('scene10-audio');

    const masterTimeline = gsap.timeline();


    // --- PHÂN CẢNH 1: Chuyển từ SCENE 1 sang SCENE 2 ---
    masterTimeline
        .to(".title-text", { opacity: 0, y: "-50%", duration: 10 }, 0)
        .to("#scene-2", { opacity: 1, duration: 10 }, "<")
        
        // **SỬA LẠI THỨ TỰ Ở ĐÂY**
        // Cho các element của Scene 2 lần lượt đi từ dưới lên theo thứ tự mới
        
        // 1. Element 5 lên trước tiên
        .to("#el-2-5", { bottom: "20%", opacity: 1, yPercent: 50, duration: 2, ease: "power2.out" }, 0.5)
        
        // 2. Element 4 lên tiếp theo
        .to("#el-2-4", { bottom: "40%", opacity: 1, yPercent: 50, duration: 2, ease: "power2.out" }, "-=1.8")
        
        // 3. Element 3
        .to("#el-2-3", { bottom: "40%", opacity: 1, yPercent: 50, duration: 2, ease: "power2.out" }, "-=1.8")
        
        // 4. Element 2
        .to("#el-2-2", { bottom: "30%", opacity: 1, yPercent: 50, duration: 2, ease: "power2.out" }, "-=1.8")
        
        // 5. Element 1 lên sau cùng
        .to("#el-2-1", { bottom: "60%", opacity: 1, yPercent: 50, duration: 2, ease: "power2.out" }, "-=1.8")
        
        .to(".scene2-subtitle", { opacity: 1, duration: 2 }, ">-1.5")
        .call(() => {
            if (scene2Audio.paused) scene2Audio.play();
        })
        .to({}, { duration: 50 }); // Khoảng lặng Scene 2

    // --- PHÂN CẢNH 2: Chuyển từ SCENE 2 sang SCENE 3 ---
    masterTimeline
        // **SỬA Ở ĐÂY**: Thêm duration để làm chậm chuyển cảnh
        .to([".scene2-element", ".scene2-subtitle"], {
            opacity: 0,
            y: "+=50",
            duration: 10, // <-- Thêm thời gian chuyển cảnh
            ease: "power2.inOut"
        })
        .to(".scene2-bg", {
            opacity: 0,
            duration: 10 // <-- Thêm thời gian chuyển cảnh
        }, "<")
        .to("#scene-3", {
            opacity: 1,
            duration: 10 // <-- Thêm thời gian chuyển cảnh
        }, "<")
        .to(["#s3-el1", "#s3-text1"], {
            opacity: 1,
            duration: 10, // <-- Thêm thời gian chuyển cảnh
            onStart: () => {
                scene2Audio.pause();
                scene2Audio.currentTime = 0;
                if (scene3Audio1.paused) {
                    scene3Audio1.play();
                }
            }
        }, "<+=0.5"); // Bắt đầu sau 0.5s để hiệu ứng mượt hơn

    // --- PHÂN CẢNH 3: Animation bên trong SCENE 3 ---
    masterTimeline
        .to({}, { duration: 50 }) // Khoảng lặng S3 el1

        // **SỬA Ở ĐÂY**: Thêm duration để làm chậm chuyển cảnh
        .to(["#s3-el1", "#s3-text1"], {
            opacity: 0,
            duration: 50 // <-- Thêm thời gian chuyển cảnh
        })
        .to(["#s3-el2", "#s3-text2"], {
            opacity: 1,
            duration: 50, // <-- Thêm thời gian chuyển cảnh
            onStart: () => {
                scene3Audio1.pause();
                scene3Audio1.currentTime = 0;
                if (scene3Audio2.paused) {
                    scene3Audio2.play();
                }
            }
        }, "<")
        .to({}, { duration: 5 }); // Khoảng lặng S3 el2



    // --- PHÂN CẢNH 4: Chuyển từ SCENE 3 sang SCENE 4 ---
    masterTimeline
        .to("#scene-3", { opacity: 0, duration: 10 })
        .to("#scene-4", { opacity: 1, duration: 10 }, "<")
        .to(".scene4-bg", { opacity: 1, duration: 10 }, "<");

    // --- Animation bên trong SCENE 4 ---
    masterTimeline
        // Khoảng lặng ngắn sau khi nền hiện ra
        .to({}, { duration: 5 })

        // **SỬA Ở ĐÂY**: Làm chậm chuyển động, thêm audio và text
        .call(() => {
            // Bật audio của Scene 4 ngay khi các element bắt đầu bay vào
            scene3Audio2.pause();
            scene3Audio2.currentTime = 0;
            if (scene4Audio && scene4Audio.paused) {
                scene4Audio.play();
            }
        })
        .to(["#s4-1L", "#s4-2L"], {
            opacity: 1,
            scale: 1,
            duration: 4, // <-- LÀM CHẬM LẠI (tăng từ 2.5 lên 4)
            left: "0%",
            bottom: "0%",
            ease: "power2.inOut",
            stagger: 0.5
        })
        .to(["#s4-1R", "#s4-2R"], {
            opacity: 1,
            scale: 1,
            duration: 4, // <-- LÀM CHẬM LẠI (tăng từ 2.5 lên 4)
            right: "0%",
            bottom: "0%",
            ease: "power2.inOut",
            stagger: 0.5
        }, "<")
        .to("#s4-text", { // <-- THÊM TEXT VÀO
            opacity: 1,
            duration: 2
        }, ">-2.0") // Bắt đầu khi animation của các element L/R còn 2s là kết thúc

        // Khoảng lặng để người xem chiêm ngưỡng
        .to({}, { duration: 10 })

        // Element 3 đi từ dưới lên
        .to("#s4-3", {
            opacity: 1,
            bottom: "auto",
            top: "0%",
            duration: 2.5,
            ease: "elastic.out(1, 0.5)"
        })

        // Khoảng lặng cuối cùng cho Scene 4
        .to({}, { duration: 50 });



    // =======================================================
    // BỔ SUNG MỚI: Chuyển từ SCENE 4 sang SCENE 5
    // =======================================================
    masterTimeline
        // Outro cho Scene 4
        // 1. Element 3 bay thẳng lên
        .to("#s4-3", { top: "-50%", duration: 2, ease: "power2.in" })
        // 2. Các element L/R zoom to và bay ra ngoài
        .to(["#s4-1L", "#s4-2L"], { scale: 1.5, left: "-50%", duration: 2, ease: "power2.in" }, "<")
        .to(["#s4-1R", "#s4-2R"], { scale: 1.5, right: "-50%", duration: 2, ease: "power2.in" }, "<")
        // 3. Background S4 mờ đi, background S5 hiện ra
        .to([".scene4-bg", "#s4-text"], { opacity: 0, duration: 2 }, ">-0.5")
        .to("#scene-5", { opacity: 1, duration: 2 }, "<") // Làm hiện cả container S5
        .to(".scene5-bg", { opacity: 1, duration: 2 }, "<");

   

    // --- Animation bên trong SCENE 5 ---
    masterTimeline
        .call(() => {
            scene4Audio.pause(); scene4Audio.currentTime = 0;
            if (scene5Audio && scene5Audio.paused) {
                scene5Audio.play();
            }
        })
        .to("#s5-el1", { top: "13%", opacity: 1, duration: 2, ease: "power3.out" })
        .to("#s5-el2", { bottom: "auto", top: "62%", opacity: 1, duration: 2, ease: "power3.out" }, "<");


    const shakeTimeline = gsap.timeline({ repeat: 3, repeatDelay: 0.1, yoyo: true });
    shakeTimeline.to(["#s5-el1", "#s5-el2"], { // Target cả 2 element cùng lúc
        x: 8, // Di chuyển sang phải 8px
        duration: 10,
        ease: "power1.inOut"
    }).to(["#s5-el1", "#s5-el2"], {
        x: -8, // Di chuyển sang trái 8px
        duration: 10,
        ease: "power1.inOut"
    });

    masterTimeline.add(shakeTimeline);

    masterTimeline
        .to("#s5-el3", { scale: 1, opacity: 1, duration: 2, ease: "elastic.out(1, 0.5)" }, "<+=0.5")
        .to("#s5-text", { opacity: 1, duration: 2 }, ">-1.0")
        .to({}, { duration: 20 });

   
    // =======================================================
    // SỬA LẠI THỨ TỰ: Chuyển từ SCENE 5 sang SCENE 6
    // =======================================================
    masterTimeline
        // 1. Background S5 mờ đi, BG S6 hiện lên trước
        .to(".scene5-bg", { opacity: 0, duration: 10 })
        .to("#scene-6", { opacity: 1, duration: 10 }, "<")
        .to(".scene6-bg", { opacity: 1, duration: 10 }, "<")

        // 2. Element 1, 2 của S6 vào vị trí TRƯỚC, bật audio
        .call(() => {
            scene5Audio.pause(); scene5Audio.currentTime = 0;
            if (scene6Audio && scene6Audio.paused) {
                scene6Audio.play();
            }
        })
        .to(["#s6-el1", "#s6-el2"], {
            bottom: "5%",
            top: "auto",
            scale: 1,
            opacity: 1,
            duration: 2.5,
            ease: "power3.out",
            stagger: 0.3
        });

   
    // =======================================================
    // SỬA LẠI HOÀN TOÀN: Chuyển từ SCENE 5 sang SCENE 6
    // =======================================================
    masterTimeline
        // 1. Nền S6 hiện ra, ĐỒNG THỜI text S5 mất đi
        .to(".scene5-bg", { opacity: 0, duration: 10 })
        .to("#s5-text", { opacity: 0, duration: 10 }, "<") // Text S5 mất cùng lúc
        .to("#scene-6", { opacity: 1, duration: 10 }, "<")
        .to(".scene6-bg", { opacity: 1, duration: 10 }, "<")

        // 2. Element 1, 2 của S6 vào vị trí TRƯỚC, bật audio
        .call(() => {
            scene5Audio.pause(); scene5Audio.currentTime = 0;
            if (scene6Audio && scene6Audio.paused) {
                scene6Audio.play();
            }
        })
        .fromTo(["#s6-el1", "#s6-el2"],
            {
                // Trạng thái BẮT ĐẦU: zoom to và ở bên dưới
                scale: 1.5,
                y: "100%", // y: "100%" nghĩa là nằm hẳn ở dưới màn hình
                opacity: 0,
            },
            {
                // Trạng thái KẾT THÚC: kích thước chuẩn và về đúng vị trí (sát đáy)
                scale: 1,
                y: "0%",
                opacity: 1,
                duration: 2.5,
                ease: "power2.out",
                bottom: "0%",
                stagger: 0.3
            }
        )

        // 3. Sau đó, các element còn lại của S5 mới mờ đi
        .to(["#s5-el1", "#s5-el2", "#s5-el3"], {
            opacity: 0,
            duration: 1
        })
        // ĐỒNG THỜI, element 3 của S6 hiện ra
        .to("#s6-el3", {
            opacity: 1,
            duration: 2
        }, "<")

        // 4. Text của S6 hiện ra sau cùng
        .to("#s6-text", { opacity: 1, duration: 2 }, ">-1.0")

        // Khoảng lặng cuối cùng cho Scene 6
        .to({}, { duration: 50 });



    // =======================================================
    // BỔ SUNG MỚI: Chuyển từ SCENE 6 sang SCENE 7
    // =======================================================
    masterTimeline
        // 1. Element S6 mờ đi, ĐỒNG THỜI BG và El1 của S7 hiện ra
        .to("#scene-6", { opacity: 0, duration: 10 })
        .to("#scene-7", { opacity: 1, duration: 10 }, "<")
        .to([".scene7-bg", "#s7-el1"], { opacity: 1, duration: 10 }, "<")
        .to("#s7-text", { opacity: 1, duration: 10 }, "<")
        .call(() => {
            scene6Audio.pause(); scene6Audio.currentTime = 0;
            if (scene7Audio && scene7Audio.paused) {
                scene7Audio.play();
            }
        }, [], "<+=1.0"); // Bật audio sau khi chuyển cảnh bắt đầu 1s

    // --- Animation bên trong SCENE 7 ---
    masterTimeline
        // 2. Element 2 đi từ dưới lên
        .to("#s7-el2", {
            bottom: "0%",
            opacity: 1,
            duration: 2.5,
            ease: "power2.out"
        })
        // 3. **SỬA Ở ĐÂY**: Element 3 đi vào góc trái-dưới, Element 4 đi vào giữa
        .to("#s7-el3", {
            left: "0%", // Về sát lề trái
            bottom: "0%", // Về sát đáy
            transform: "none", // Bỏ transform căn giữa
            opacity: 1,
            duration: 3,
            ease: "power3.out"
        }, "-=2.0") // Thời gian bắt đầu giữ nguyên
        .to("#s7-el4", {
            left: "50%",
            bottom: "5%",
        transform: "translateX(-50%)",
            opacity: 1,
            duration: 3,
            ease: "power3.out"
        }, "<") // Element 4 vẫn đi vào giữa cùng lúc

        // Khoảng lặng cuối cùng cho Scene 7
        .to({}, { duration: 50 });


     0
    // =======================================================
    // SỬA LẠI: Chuyển từ SCENE 7 sang SCENE 8
    // =======================================================
    masterTimeline
        // 1. Outro cho Scene 7: Mờ dần và fade sang phải
        .to("#scene-7", {
            opacity: 0,
            x: "50%",
            duration: 2,
            ease: "power2.in"
        })
        // 2. Intro cho Scene 8: Nền hiện ra cùng lúc
        .to("#scene-8", { opacity: 1, duration: 10 }, "<")
        .to(".scene8-bg", { opacity: 1, duration: 10 }, "<");

    // --- Animation bên trong SCENE 8 ---
    masterTimeline
        .call(() => {
            scene7Audio.pause(); scene7Audio.currentTime = 0;
            if (scene8Audio && scene8Audio.paused) {
                scene8Audio.play();
            }
        })
        // 3. Element 1, 3, 4 (zoom) đi từ dưới lên và thu nhỏ lại
        .to(["#s8-el1", "#s8-el3", "#s8-el4"], {
            bottom: "0%",
            scale: 1,
            opacity: 1,
            duration: 3,
            ease: "power3.out",
            stagger: 0.3
        })
        // 4. Element 2 (không zoom) đi từ dưới lên cùng lúc
        .to("#s8-el2", {
            bottom: "5%",
            opacity: 1,
            duration: 3,
            ease: "power3.out"
        }, "<")
        // 5. Text hiện ra
        .to("#s8-text", { opacity: 1, duration: 2 }, ">-1.5")

        // Khoảng lặng cuối cùng cho Scene 8
        .to({}, { duration: 50 });
        

         // --- PHÂN CẢNH 8 -> SCENE 9 (Cảnh cuối) ---
    masterTimeline
        .to("#scene-8", { opacity: 0, duration: 10 }) // Mờ đi scene 8
        .to("#scene-9", { opacity: 1, duration: 10 }, "<") // Hiện ra scene 9
        // Element, text của Scene 9 hiện ra cùng lúc

        masterTimeline
        .call(() => {
            scene8Audio.pause(); scene8Audio.currentTime = 0;
            if (scene9Audio && scene9Audio.paused) {
                scene9Audio.play();
            }
        })
        .to(["#s9-el1", "#s9-text"], { opacity: 1, duration: 3, stagger: 0.5 }, "<")

        // Khoảng lặng cuối cùng cho Scene 8
        .to({}, { duration: 50 });
    
    // ScrollTrigger.create() giữ nguyên, không thay đổi
    ScrollTrigger.create({
        trigger: "#pin-container",
        start: "top top",
        end: () => "+=" + masterTimeline.totalDuration() * 150,
        scrub: 1,
        pin: true,
        animation: masterTimeline
    });


}

