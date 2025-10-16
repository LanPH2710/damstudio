gsap.registerPlugin(ScrollTrigger);

// ✅ QUAN TRỌNG: Cuộn về đầu trang ngay khi script được tải
window.addEventListener('load', () => {
    // Đảm bảo cuộn về top khi trang vừa load xong
    window.scrollTo(0, 0); 
    
    // Nếu trang quá nhanh, có thể cần một chút độ trễ cho trình duyệt
    // setTimeout(() => {
    //     window.scrollTo(0, 0); 
    // }, 50);
});

// ... (Các phần Khai báo Biến & Setup BAN ĐẦU giữ nguyên) ...
// --- 1. KHAI BÁO BIẾN & SETUP BAN ĐẦU ---

const audio1 = document.getElementById("scene1-audio1");     // s1.mp3
const audio2 = document.getElementById("scene1-audio1_1");   // s1_1.mp3
const audio3 = document.getElementById("scene1-audio1_2");   // s1_2.mp3
const audio4 = document.getElementById("scene1-audio1_3");   // s1_3.mp3
const audio5 = document.getElementById("scene1-audio1_4");   // s1_4.mp3
const audio6 = document.getElementById("scene1-audio1_5");   // s1_5.mp3
const audio7 = document.getElementById("scene2-audio");   // s1_6.mp3
const audio8 = document.getElementById("scene4-audio");   // s1_7.mp3
const audio9 = document.getElementById("scene5-audio");   // s1_8.mp3
const audio10 = document.getElementById("scene6-audio");   // s1_9.mp3
const audio11 = document.getElementById("scene7-audio");   // s1_9.mp3
const audio12 = document.getElementById("scene8-audio");   // s1_9.mp3
const audio13 = document.getElementById("scene9-audio9_1");   // s1_9.mp3
const audio14 = document.getElementById("scene9-audio9_2");   // s1_9.mp3

const startScreen = document.getElementById('start-screen');
const startButton = document.getElementById('start-button');
const pinContainer = document.getElementById('pin-container');

// Danh sách audio (chỉ cần element và tên)
const allVoiceAudios = [audio1, audio2, audio3, audio4, audio5, audio6, audio7, audio8, audio9, audio10, audio11, audio12, audio13, audio14];

let currentPlayingAudio = null;
let lastScrollY = 0;

// Hàm dừng tất cả audio giọng đọc
function stopAllVoiceAudios() {
    allVoiceAudios.forEach(item => {
        item.pause();
    });
    currentPlayingAudio = null;
    console.log("[AUDIO EVENT] 🛑 STOP ALL.");
}

// Hàm Play với logic dừng audio khác
function playAudio(audioElement) {
    if (currentPlayingAudio === audioElement) return;

    stopAllVoiceAudios();

    audioElement.currentTime = 0;

    audioElement.play().catch(e => {
        console.error("Lỗi phát audio (sau khi click):", e);
    });

    currentPlayingAudio = audioElement;
    console.log(`[AUDIO EVENT] ✅ START PLAYING: ${audioElement.id}`);
}


// --- 2. XỬ LÝ NÚT START (Vượt Autoplay Policy) ---

startButton.addEventListener('click', () => {
    allVoiceAudios.forEach(item => {
        item.play().catch(e => console.error("Autoplay setup failed:", e));
        item.pause();
        item.currentTime = 0;
    });

    startScreen.style.opacity = '0';
    document.body.style.overflowY = 'auto';
    setTimeout(() => {
        startScreen.style.display = 'none';
    }, 500);
});


// --- 3. GSAP TIMELINE VỚI .call() ---

const tl = gsap.timeline({
    scrollTrigger: {
        trigger: "#pin-container",
        start: "top top",
        end: "+=15000",  // Độ dài cuộn
        scrub: 1,
        pin: true,
    }
});


// --- 4. TIMELINE ANIMATION VÀ .call() AUDIO ---

// =================================================================
// INTRO SCENE TO SCENE 1 (Thêm Text 1 và Audio S1 Intro)
// =================================================================

tl.to(".title-text", { opacity: 0, y: 150, duration: 1 });
tl.to("#scene-intro", { opacity: 0, duration: 1.5 }, "<0.5");

// Element intro của Scene 1 và Text 1 hiện ra cùng lúc
tl.to("#el-1-intro", { opacity: 1, duration: 1.5 }, "<");
tl.to("#text-1-1", { opacity: 1, y: 0, duration: 1.5 }, "<"); // Giả định #text-1-1 là Text Intro

// GỌI HÀM PHÁT AUDIO S1 Intro (audio1)
tl.call(playAudio, [audio1], "<");

// TẠO KHOẢNG NGHỈ CUỘN DÀI
tl.to({}, { duration: 0.1 }, "+=4"); // 4 giây cuộn (khoảng thời gian audio1 phát)
// =================================================================
// BƯỚC 1: Hiện 4 Element (1, 2, 3, 4) + Text 2 + Audio s1_1
// =================================================================

// Ẩn element intro và hiện 4 element đầu
tl.to("#el-1-intro", { opacity: 0, duration: 1 });
tl.to("#text-1-1", { opacity: 0, duration: 1 });
tl.to(["#el-1-1", "#el-1-2", "#el-1-3", "#el-1-4"], { opacity: 1, duration: 1 }, "<");

// Hiện Text 2 (text-1-2) đi từ dưới lên
tl.to("#text-1-2", { opacity: 1, y: 0, duration: 1 }, "<0.5");

// GỌI HÀM PHÁT AUDIO s1_1 (audio2)
tl.call(playAudio, [audio2], "<");

// TẠO KHOẢNG NGHỈ CUỘN DÀI
tl.to({}, { duration: 0.1 }, "+=4");


// =================================================================
// BƯỚC 2: Element 5, 6, 7 vào + Text 3 + Audio s1_2
// =================================================================

// Ẩn Text 2 (text-1-2)
tl.to("#text-1-2", { opacity: 0, y: -50, duration: 0.5 });

// Element 5 & 6 đi vào từ trái
tl.fromTo(["#el-1-5", "#el-1-6"],
    { x: "-100%", opacity: 0 },
    { x: "0%", opacity: 1, duration: 1.5 });

// Element 7 đi vào từ phải
tl.fromTo("#el-1-8",
    { x: "100%", opacity: 0 },
    { x: "0%", opacity: 1, duration: 1.5 }, "<"); // Chạy song song với 5 & 6

// Hiện Text 3 (text-1-3)
tl.to("#text-1-3", { opacity: 1, y: 0, duration: 1 }, "<0.5");

// GỌI HÀM PHÁT AUDIO s1_2 (audio3)
tl.call(playAudio, [audio3], "<");

// TẠO KHOẢNG NGHỈ CUỘN DÀI
tl.to({}, { duration: 0.1 }, "+=4");


// =================================================================
// BƯỚC 3: Element 7 vào + Text 3 (giữ nguyên text) + Audio s1_3
// =================================================================
tl.to("#text-1-3", { opacity: 0, y: -50, duration: 0.5 });
tl.fromTo("#el-1-7",
    { x: "100%", opacity: 0 },
    { x: "0%", opacity: 1, duration: 1.5 });
tl.to("#text-1-4", { opacity: 1, y: 0, duration: 1 }, "<0.5");
// GỌI HÀM PHÁT AUDIO s1_3 (audio4)
tl.call(playAudio, [audio4], "<");

// TẠO KHOẢNG NGHỈ CUỘN DÀI
tl.to({}, { duration: 0.1 }, "+=6");

// Ẩn Text 3
tl.to("#text-1-4", { opacity: 0, y: -50, duration: 0.5 });

// =================================================================
// BƯỚC 4: Text 5 + Audio 5 + Element di chuyển
// =================================================================

// Text 4 mờ đi
tl.to("#text-1-4", { opacity: 0, y: -50, duration: 0.5 });

// Element 5,6 lùi ra (hướng 8h: X âm, Y âm)
tl.to(["#el-1-5", "#el-1-6"], { x: "-=50", y: "+=50", duration: 1 }, "<0.2");

// Element 7,8 lùi ra (hướng 4h: X dương, Y dương)
tl.to(["#el-1-7", "#el-1-8"], { x: "+=50", y: "+=50", duration: 1 }, "<");

// Text 5 hiện lên
tl.to("#text-1-5", { opacity: 1, y: 0, duration: 1 }, "<");

// GỌI HÀM PHÁT AUDIO 5
tl.call(playAudio, [audio5], "<");

// TẠO KHOẢNG NGHỈ CUỘN DÀI
tl.to({}, { duration: 0.1 }, "+=4");


// =================================================================
// BƯỚC 5: Text 6 + Audio 6 (Kết thúc Scene 1)
// =================================================================

// Text 5 mờ đi
tl.to("#text-1-5", { opacity: 0, y: -50, duration: 0.5 });

// Text 6 hiện lên
tl.to("#text-1-6", { opacity: 1, y: 0, duration: 1 }, "<");

// GỌI HÀM PHÁT AUDIO 6
tl.call(playAudio, [audio6], "<");

// TẠO KHOẢNG NGHỈ CUỘN DÀI
tl.to({}, { duration: 0.1 }, "+=4");


// =================================================================
// SCENE 1 KẾT THÚC & CHUYỂN CẢNH SANG SCENE 2
// =================================================================

// Ẩn tất cả element và text của Scene 1
tl.to([".scene1-element", ".scene1-subtitle"], { opacity: 0, duration: 1 });

// DỪNG audio đang phát (audio 6)
// tl.call(stopAllVoiceAudios, [], "<");

// Scene 1 mờ dần
tl.to("#scene-1", { y: -100, opacity: 0, duration: 2 }, "<0.5");

// Hiện Element Intro của Scene 2 (Giả định ID là el-2-intro)
// Lưu ý: Đảm bảo #scene-2 nằm dưới #scene-1 trong HTML
tl.to("#el-2-1", { opacity: 1, duration: 2 }, "<1");
tl.to({}, { duration: 2 });
// DỪNG audio đang phát khi Scene 1 kết thúc
// tl.call(stopAllVoiceAudios, [], "<");
// tl.to({}, { duration: 2 });

// =================================================================
// CHUYỂN CẢNH SANG SCENE 2
// =================================================================

// Ẩn tất cả element và text của Scene 1
tl.to([".scene1-element", ".scene1-subtitle"], { opacity: 0, duration: 1 });

// DỪNG audio đang phát (audio 6)
tl.call(stopAllVoiceAudios, [], "<");

// Scene 1 mờ dần và dịch chuyển
tl.to("#scene-1", { y: -100, opacity: 0, duration: 2 }, "<0.5");

// ✅ Element 1 của Scene 2 hiện ra
tl.to("#el-2-1", { opacity: 1, duration: 2 }, "<1");

// ✅ Element 2, 3, 4 đi từ dưới lên
tl.fromTo(["#el-2-2", "#el-2-3", "#el-2-4"],
    { y: "100%", opacity: 0 },
    { y: "0%", opacity: 1, duration: 1.5 }, "<");

// TẠO KHOẢNG NGHỈ CUỘN
tl.to({}, { duration: 0.1 }, "+=3");


// =================================================================
// SCENE 2 - BƯỚC 1: Element 5, 6, 7, 8 + Text + Audio
// =================================================================

// ✅ Element 5 đi từ trái vào center
tl.fromTo("#el-2-5",
    { x: "-100%", opacity: 0 },
    { x: "0%", opacity: 1, duration: 1.5 });

// ✅ Element 6 hiện ra
tl.to("#el-2-6", { opacity: 1, duration: 1 }, "<0.5");

// ✅ Element 7, 8 đi từ phải vào
tl.fromTo(["#el-2-7", "#el-2-8"],
    { x: "100%", opacity: 0 },
    { x: "0%", opacity: 1, duration: 1.5 }, "<");

// ✅ Text đi từ trên xuống (giả sử là #text-2-1)
tl.fromTo("#text-2-1",
    { y: "-100%", opacity: 0 },
    { y: "0%", opacity: 1, duration: 1.5 }, "<0.5");

// GỌI HÀM PHÁT AUDIO SCENE 2
tl.call(playAudio, [audio7], "<");

// TẠO KHOẢNG NGHỈ CUỘN DÀI
tl.to({}, { duration: 0.1 }, "+=6");

// Ẩn Text 2
tl.to("#text-2-1", { opacity: 0, y: -50, duration: 0.5 });

// ✅ CHỖ NÀY BẮT ĐẦU CHO BƯỚC TIẾP THEO CỦA SCENE 2
// =================================================================
// CHUYỂN CẢNH SANG SCENE 3 (Giữ nguyên)
// =================================================================

// Element 7, 8 của Scene 2 di dần sang trái và mờ dần
tl.to(["#el-2-7", "#el-2-8"], { x: "-100%", opacity: 0, duration: 1.5 });

// Các element khác của Scene 2 mờ dần tại chỗ (Chạy đồng thời với 7, 8)
tl.to(["#el-2-1", "#el-2-2", "#el-2-3", "#el-2-4", "#el-2-5", "#el-2-6"], { opacity: 0, duration: 1.5 }, "<");

// DỪNG audio đang phát của Scene 2
tl.call(stopAllVoiceAudios, [], "<");

// Scene 2 mờ dần và dịch chuyển
tl.to("#scene-2", { y: -100, opacity: 0, duration: 2 }, "<0.5");

// Element 1 Scene 3 xuất hiện ra
tl.to("#el-3-1", { opacity: 1, duration: 2 }, "<1");

// TẠO KHOẢNG NGHỈ CUỘN
tl.to({}, { duration: 0.1 }, "+=3");


// =================================================================
// SCENE 3 - BƯỚC 1: Element 2, 3, 4, 5 + Text 3-1 (KHÔNG CÓ AUDIO)
// =================================================================

// Element 2, 3 hiện ra tại chỗ
tl.to(["#el-3-2", "#el-3-3"], { opacity: 1, duration: 1.5 });

// Element 4 đi từ trái vào center
tl.fromTo("#el-3-4",
    { x: "-100%", opacity: 0 },
    { x: "0%", opacity: 1, duration: 1.5 }, "<");

// ✅ Element 5 đi từ trái vào center (Đã xóa scaleX)
tl.fromTo("#el-3-5",
    { x: "-100%", opacity: 0 }, // ✅ Bỏ scaleX: -1 ở đây
    { x: "0%", opacity: 1, duration: 1.5 }, "<"); // ✅ Bỏ scaleX: -1 ở đây
// Text hiện ra từ trên (giả sử là #text-3-1)
tl.fromTo("#text-3-1",
    { y: "-100%", opacity: 0 },
    { y: "0%", opacity: 1, duration: 1.5 }, "<0.5");

// ✅ KHÔNG GỌI HÀM PHÁT AUDIO TẠI ĐÂY NỮA

// TẠO KHOẢNG NGHỈ CUỘN DÀI (Giả sử 6 giây cuộn để đọc/xem animation)
tl.to({}, { duration: 0.1 }, "+=6");

// =================================================================
// CHUYỂN CẢNH SANG SCENE 4
// =================================================================

//  Element 4, 5 tiếp tục đi sang phải và mờ dần
tl.to(["#el-3-4", "#el-3-5"], { x: "100%", opacity: 0, duration: 1.5 });

//  Element 3 đi sang trái và mờ dần
tl.to("#el-3-3", { x: "-100%", opacity: 0, duration: 1.5 }, "<");

//  Các element còn lại (1, 2) mờ dần tại chỗ
tl.to(["#el-3-1", "#el-3-2", "#text-3-1"], { opacity: 0, duration: 1.5 }, "<");

// DỪNG audio đang phát (nếu có, nhưng Scene 3 không có)
tl.call(stopAllVoiceAudios, [], "<");

// Scene 3 mờ dần và dịch chuyển
tl.to("#scene-3", { y: -100, opacity: 0, duration: 2 }, "<0.5");

//  Element 1, 2 của Scene 4 hiện ra (Nền)
tl.to(["#el-4-1", "#el-4-2"], { opacity: 1, duration: 2 }, "<1");

// TẠO KHOẢNG NGHỈ CUỘN
tl.to({}, { duration: 0.1 }, "+=3");


// =================================================================
// SCENE 4 - BƯỚC 1: Sự xuất hiện của Thủy Tinh (Thủy Quái)
// =================================================================

//  Element 3 đi từ trên xuống center
tl.fromTo("#el-4-3",
    { y: "-100%", opacity: 0 },
    { y: "0%", opacity: 1, duration: 1.5 });

//  Element 4, 5, 6, 7 đi từ dưới lên center
tl.fromTo(["#el-4-4", "#el-4-5", "#el-4-6", "#el-4-7"],
    { y: "100%", opacity: 0 },
    { y: "0%", opacity: 1, duration: 1.5 }, "<");

//  Element 8, 9 đi từ hướng 7 giờ (Trái-Dưới) lên center
// (Giả sử: Bắt đầu từ x: -100% và y: 100%)
tl.fromTo(["#el-4-8", "#el-4-9"],
    { x: "-100%", y: "100%", opacity: 0 },
    { x: "0%", y: "0%", opacity: 1, duration: 1.5 }, "<");

//  Text hiện ra từ trên xuống (giả sử là #text-4-1 - class scene4-subtitle)
tl.fromTo(".scene4-subtitle",
    { y: "-100%", opacity: 0 },
    { y: "0%", opacity: 1, duration: 1.5 }, "<0.5");

// GỌI HÀM PHÁT AUDIO SCENE 4
tl.call(playAudio, [audio8], "<");

// TẠO KHOẢNG NGHỈ CUỘN DÀI
tl.to({}, { duration: 0.1 }, "+=8"); // 8 giây cuộn cho giọng đọc dài


// --- 4. TIMELINE ANIMATION VÀ .call() AUDIO ---
// ... (Đoạn Code Scene 1, 2, 3, 4 giữ nguyên) ...

// SCENE 4 - BƯỚC 1: Sự xuất hiện của Thủy Tinh (Kết thúc)
tl.to({}, { duration: 3 }); // Khoảng nghỉ cuối Scene 4 - BƯỚC 1 (đã có ở lần sửa trước)


// =================================================================
// CHUYỂN CẢNH SANG SCENE 5 (Đã sửa để tạo hiệu ứng nối tiếp)
// =================================================================

// Ẩn Text Scene 4 trước
tl.to(".scene4-subtitle", { opacity: 0, duration: 0.5 });

// ✅ Element 1, 2 Scene 4 mờ đi (tại chỗ)
tl.to(["#el-4-1", "#el-4-2"], { opacity: 0, duration: 1 });

// ✅ Element 3 Scene 4 đi lên
tl.to("#el-4-3", { y: "-100%", opacity: 0, duration: 1.5 }, "<");

// ✅ Scene 4: Các Element cũ (4, 5, 6, 7, 8, 9) lùi dần sang trái và mờ dần
tl.to(["#el-4-4", "#el-4-5", "#el-4-6", "#el-4-7", "#el-4-8", "#el-4-9"],
    { x: "-100%", duration: 1.5, opacity: 0 }); // Nhãn mặc định: '+='

// --------------------------------------------------------------------------
// ✅ HIỆU ỨNG NỐI TIẾP: Scene 5 vào cùng lúc Scene 4 ra (Dùng nhãn "<")
// --------------------------------------------------------------------------

// ✅ Element 3, 4 Scene 5 đi từ ngoài màn hình bên phải đi vào center
tl.fromTo(["#el-5-3", "#el-5-4"],
    { x: "100%", opacity: 0 },
    { x: "0%", opacity: 1, duration: 1.5 }, "<"); // <<== Chạy cùng lúc với Element 4 ra

// ✅ Element 1 Scene 5 hiện ra (Chạy sau 0.5s)
tl.to("#el-5-1", { opacity: 1, duration: 2 }, "<0.5");

// Scene 4 mờ dần và dịch chuyển
tl.to("#scene-4", { y: -100, opacity: 0, duration: 2 }, "<0.5");

// DỪNG audio đang phát của Scene 4
tl.call(stopAllVoiceAudios, [], "<");

// TẠO KHOẢNG NGHỈ CUỘN ngắn trước khi Scene 5 BƯỚC 1 vào
tl.to({}, { duration: 0.1 }, "+=1");


// =================================================================
// SCENE 5 - BƯỚC 1: Element 2 + Text + Audio 5
// =================================================================

// Element 2 đi lên từ dưới lên
tl.fromTo("#el-5-2",
    { y: "100%", opacity: 0 },
    { y: "0%", opacity: 1, duration: 1.5 });

// Text và audio xuất hiện (Giả sử là #text-5-1)
tl.fromTo("#text-5-1",
    { y: "-100%", opacity: 0 },
    { y: "0%", opacity: 1, duration: 1.5 }, "<0.5");

// GỌI HÀM PHÁT AUDIO SCENE 5
tl.call(playAudio, [audio9], "<");

// TẠO KHOẢNG NGHỈ CUỘN DÀI
tl.to({}, { duration: 0.1 }, "+=8");


// --- 4. TIMELINE ANIMATION VÀ .call() AUDIO ---
// ... (Đoạn Code Scene 1, 2, 3, 4, 5 giữ nguyên) ...

// SCENE 5 - BƯỚC 1: Element 2 + Text + Audio 5 (Kết thúc)
tl.to({}, { duration: 3 }); // Khoảng nghỉ cuối Scene 5 - BƯỚC 1


// =================================================================
// CHUYỂN CẢNH SANG SCENE 6
// =================================================================

// Ẩn Text Scene 5 trước
tl.to("#text-5-1", { opacity: 0, y: -50, duration: 0.5 });

// ✅ Element 1 Scene 5 mờ đi (Đặt nhãn đồng bộ)
tl.to("#el-5-1", { opacity: 0, duration: 1.5 }, "startTransitionS5S6");

// ✅ Element 1 của Scene 6 hiện ra (Chạy đồng thời với 5-1 mờ đi)
tl.to("#el-6-1", { opacity: 1, duration: 2 }, "startTransitionS5S6");

// Các Element Scene 5 còn lại mờ đi và dịch chuyển ra khỏi tầm nhìn
tl.to(["#el-5-2", "#el-5-3", "#el-5-4"],
    { opacity: 0, y: "100%", duration: 1.5 }, "startTransitionS5S6");

// Scene 5 mờ dần và dịch chuyển
tl.to("#scene-5", { y: -100, opacity: 0, duration: 2 }, "<0.5");

// DỪNG audio đang phát của Scene 5
tl.call(stopAllVoiceAudios, [], "<");

// TẠO KHOẢNG NGHỈ CUỘN
tl.to({}, { duration: 0.1 }, "+=3");


// =================================================================
// SCENE 6 - BƯỚC 1: Sự xuất hiện của các Element
// =================================================================

// ✅ Element 2, 4, 5, 6 đi vào giữa từ hướng 7 giờ (Trái-Dưới)
// (Bắt đầu từ x: -100% và y: 100%)
tl.fromTo(["#el-6-2", "#el-6-4", "#el-6-5", "#el-6-6"],
    { x: "-100%", y: "100%", opacity: 0 },
    { x: "0%", y: "0%", opacity: 1, duration: 1.5 });

// ✅ Element 3, 7 đi vào center từ hướng 4 giờ rưỡi (Phải-Dưới)
// (Bắt đầu từ x: 100% và y: 100%)
tl.fromTo(["#el-6-3", "#el-6-7"],
    { x: "100%", y: "100%", opacity: 0 },
    { x: "0%", y: "0%", opacity: 1, duration: 1.5 }, "<");

// ✅ Text đi từ trên xuống (giả sử là #text-6-1 - class scene6-subtitle)
tl.fromTo("#text-6-1",
    { y: "-100%", opacity: 0 },
    { y: "0%", opacity: 1, duration: 1.5 }, "<0.5");

// GỌI HÀM PHÁT AUDIO SCENE 6
tl.call(playAudio, [audio10], "<");

// TẠO KHOẢNG NGHỈ CUỘN DÀI
tl.to({}, { duration: 0.1 }, "+=8");


// =================================================================
// CHUYỂN CẢNH SANG SCENE 7
// =================================================================

// Ẩn Text Scene 6 trước
tl.to("#text-6-1", { opacity: 0, y: -50, duration: 0.5 });

// ✅ Element 1 Scene 7 hiện ra (Đặt nhãn đồng bộ)
tl.to("#el-7-1", { opacity: 1, duration: 2 }, "startTransitionS6S7");

// ✅ Các Element Scene 6 mờ đi
tl.to([".scene6-element"], { opacity: 0, duration: 1.5 }, "startTransitionS6S7");

// Scene 6 mờ dần và dịch chuyển
tl.to("#scene-6", { y: -100, opacity: 0, duration: 2 }, "<0.5");

// DỪNG audio đang phát của Scene 6
tl.call(stopAllVoiceAudios, [], "<");

// TẠO KHOẢNG NGHỈ CUỘN ngắn
tl.to({}, { duration: 0.1 }, "+=1");


// =================================================================
// SCENE 7 - BƯỚC 1: Element 2, 3, 4, 5 + Text + Audio 7
// =================================================================

// ✅ Element 2, 3, 4, 5 đi từ dưới vào center
tl.fromTo(["#el-7-2", "#el-7-3", "#el-7-4", "#el-7-5"],
    { y: "100%", opacity: 0 },
    { y: "0%", opacity: 1, duration: 1.5 });

// ✅ Text đi từ trên xuống (giả sử là #text-7-1 - class scene7-subtitle)
tl.fromTo("#text-7-1",
    { y: "-100%", opacity: 0 },
    { y: "0%", opacity: 1, duration: 1.5 }, "<0.5");

// GỌI HÀM PHÁT AUDIO SCENE 7
tl.call(playAudio, [audio11], "<");

// TẠO KHOẢNG NGHỈ CUỘN DÀI
tl.to({}, { duration: 0.1 }, "+=8");


// =================================================================
// CHUYỂN CẢNH SANG SCENE 8
// =================================================================

// Ẩn Text Scene 7 trước
tl.to("#text-7-1", { opacity: 0, y: -50, duration: 0.5 });

// ✅ Element 1 Scene 8 hiện ra (Đặt nhãn đồng bộ)
tl.to("#el-8-1", { opacity: 1, duration: 2 }, "startTransitionS7S8");

// ✅ Các Element Scene 7 mờ đi
tl.to([".scene7-element"], { opacity: 0, duration: 1.5 }, "startTransitionS7S8");

// Scene 7 mờ dần và dịch chuyển
tl.to("#scene-7", { y: -100, opacity: 0, duration: 2 }, "<0.5");

// DỪNG audio đang phát của Scene 7
tl.call(stopAllVoiceAudios, [], "<");

// TẠO KHOẢNG NGHỈ CUỘN ngắn
tl.to({}, { duration: 0.1 }, "+=1");


// =================================================================
// SCENE 8 - BƯỚC 1: Element 2, 3, 4, 5, 6 + Text + Audio 8
// =================================================================

// ✅ Element 2 Scene 8 di từ trên xuống gần top (Giả sử top 10%)
tl.fromTo("#el-8-2",
    { y: "-100%", opacity: 0, top: "50%" }, // Bắt đầu từ trên ẩn
    { y: "0%", opacity: 1, top: "0%", duration: 1.5 }); // Kết thúc gần top

// ✅ Element 3, 4, 5, 6 đi từ phải sang từ hướng 4 giờ về center
// (Bắt đầu từ x: 100% và y: 50%)
tl.fromTo(["#el-8-3", "#el-8-4", "#el-8-5", "#el-8-6"],
    { x: "100%", y: "50%", opacity: 0 },
    { x: "0%", y: "0%", opacity: 1, duration: 1.5 }, "<");

// ✅ Text đi từ trên xuống (giả sử là #text-8-1 - class scene8-subtitle)
tl.fromTo("#text-8-1",
    { y: "-100%", opacity: 0 },
    { y: "0%", opacity: 1, duration: 1.5 }, "<0.5");

// GỌI HÀM PHÁT AUDIO SCENE 8
tl.call(playAudio, [audio12], "<");

// TẠO KHOẢNG NGHỈ CUỘN DÀI
tl.to({}, { duration: 0.1 }, "+=8");


// BẮT ĐẦU CHO BƯỚC TIẾP THEO CỦA SCENE 8
tl.to({}, { duration: 3 });


// --- 5. LOGIC DỪNG AUDIO KHI CUỘN NGƯỢC (THỦ CÔNG


// --- 5. LOGIC DỪNG AUDIO KHI CUỘN NGƯỢC (THỦ CÔNG) giữ nguyên ---
let sceneStart = 0;
let sceneEnd = 0;
// --- 5. LOGIC DỪNG AUDIO KHI CUỘN NGƯỢC (THỦ CÔNG) giữ nguyên ---
// ...

ScrollTrigger.create({
    trigger: "#pin-container",
    start: "top top",
    end: "+=15000",
    onUpdate: (self) => {
        const currentScrollY = window.scrollY;

        // Kiểm tra cuộn ngược (Dừng)
        if (currentScrollY < lastScrollY && currentPlayingAudio) {
            stopAllVoiceAudios();
        }

        lastScrollY = currentScrollY;

        // Cập nhật điểm bắt đầu/kết thúc
        if (sceneStart === 0) {
            sceneStart = self.start;
            sceneEnd = self.end;
        }

        // Dừng audio nếu cuộn ra khỏi vùng Pin
        if (currentScrollY < sceneStart || currentScrollY > sceneEnd) {
            if (currentPlayingAudio) {
                stopAllVoiceAudios();
            }
        }
    }
});