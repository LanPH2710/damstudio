gsap.registerPlugin(ScrollTrigger);

    gsap.to(".title", {
      opacity: 0,
      y: -100,
      scrollTrigger: {
        trigger: "#scene",
        start: "top top",
        end: "top+=300",
        scrub: true
      }
    });

    gsap.fromTo("#BG", { opacity: 0 }, {
      opacity: 1,
      scrollTrigger: {
        trigger: "#scene",
        start: "top+=200",
        end: "top+=400",
        scrub: true
      }
    });

    const elements = [
      { id: "floor", scale: 1.56 },
      { id: "house1", scale: 1.52 },
      { id: "enemy1", scale: 1.28 },
      { id: "house2", scale: 1.1 },
      { id: "enemy2", scale: 1.4 },
      { id: "fire", scale: 1.16 }
    ];

    elements.forEach((el, i) => {
      gsap.fromTo(`#${el.id}`,
        { y: 100, opacity: 0 },
        {
          y: 0,
          opacity: 1,
          scrollTrigger: {
            trigger: "#scene",
            start: `top+=${400 + i * 150}`,
            end: `top+=${500 + i * 150}`,
            scrub: true
          }
        });
    });

    elements.forEach((el) => {
  gsap.fromTo(`#${el.id}`,
    { scale: 1, y: 0 },
    {
      scale: el.scale,
      y: 0,
      scrollTrigger: {
        trigger: "#scene",
        start: "top+=1400",
        end: "top+=1600",
        scrub: true
      }
    });
});

    gsap.fromTo("#floorText", { y: 100, opacity: 0 }, {
  y: 0,
  opacity: 1,
  scrollTrigger: {
    trigger: "#scene",
    start: "top+=1400", // Trùng với animation zoom
    end: "top+=1600",
    scrub: true
  }
});


    gsap.to(["#fire", "#enemy2", "#house2", "#enemy1", "#house1", "#floor", "#BG"], {
      opacity: 0,
      y: 100,
      scrollTrigger: {
        trigger: "#scene",
        start: "top+=2200",
        end: "top+=2400",
        scrub: true
      }
    });

    // gsap.fromTo("#boat", { x: -400, opacity: 0 }, {
    //   x: 0,
    //   opacity: 1,
    //   scrollTrigger: {
    //     trigger: "#scene",
    //     start: "top+=2300",
    //     end: "top+=2500",
    //     scrub: true
    //   }
    // });

    // gsap.fromTo("#sun", { y: -200, opacity: 0 }, {
    //   y: 0,
    //   opacity: 1,
    //   scrollTrigger: {
    //     trigger: "#scene",
    //     start: "top+=2400",
    //     end: "top+=2600",
    //     scrub: true
    //   }
    // });

    // ["a", "b", "c"].forEach((id, i) => {
    //   gsap.fromTo(`#${id}`, { opacity: 0 }, {
    //     opacity: 1,
    //     scrollTrigger: {
    //       trigger: "#scene",
    //       start: `top+=${2500 + i * 100}`,
    //       end: `top+=${2600 + i * 100}`,
    //       scrub: true
    //     }
    //   });
    // });

    ScrollTrigger.create({
      trigger: "#scene",
      start: "top top",
      end: "+=2800",
      pin: true,
      scrub: true
    });


