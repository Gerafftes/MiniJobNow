  // Parallax mit Easing
        let lastScrollY = window.scrollY;
        let parallaxOffset = 0;
        const parallaxSpeed = 0.05; // erhöht von 0.03
        const parallaxEasing = 0.05; // erhöht von 0.05

        function updateParallax() {
            const target = window.scrollY;
            lastScrollY = target;
            parallaxOffset += (target - parallaxOffset) * parallaxEasing;
            const heroBg = document.getElementById('parallax-hero-bg');
            if (heroBg) {
                heroBg.style.backgroundPosition = `center ${50 - parallaxOffset * parallaxSpeed}%`;
            }
            requestAnimationFrame(updateParallax);
        }
        updateParallax();

        window.addEventListener('scroll', () => {
            const header = document.querySelector('.header');
            if (window.scrollY > window.innerHeight * 0.8) {
                header.classList.add('scrolled');
            } else {
                header.classList.remove('scrolled');
            }
        });

        // Intersection Observer for animations
        const observerOptions = {
            threshold: 0.1
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('animate');
                }
            });
        }, observerOptions);

        document.querySelectorAll('.stat-item').forEach(item => {
            observer.observe(item);
        });

        // Additional animation for offering cards
        document.querySelectorAll('.offering-card, .testimonial-card').forEach(item => {
            observer.observe(item);
        });

        // Mobile menu functionality
        const mobileMenuButton = document.querySelector('.mobile-menu-button');
        const mobileMenu = document.querySelector('.mobile-menu');
        const mobileMenuClose = document.querySelector('.mobile-menu-close');
        const mobileNavLinks = document.querySelectorAll('.mobile-nav-link');

        mobileMenuButton.addEventListener('click', () => {
            mobileMenu.classList.add('active');
            document.body.style.overflow = 'hidden';
        });

        mobileMenuClose.addEventListener('click', () => {
            mobileMenu.classList.remove('active');
            document.body.style.overflow = '';
        });

        mobileNavLinks.forEach(link => {
            link.addEventListener('click', () => {
                mobileMenu.classList.remove('active');
                document.body.style.overflow = '';
            });
        });

        // Additional animations
        const fadeElements = document.querySelectorAll('.fade-up');
        const scaleElements = document.querySelectorAll('.scale-in');

        const fadeObserver = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('visible');
                }
            });
        }, { threshold: 0.1 });

        fadeElements.forEach(element => {
            fadeObserver.observe(element);
        });

        scaleElements.forEach(element => {
            fadeObserver.observe(element);
        });

        // Smooth scroll with offset for fixed header
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    const headerOffset = 80;
                    const elementPosition = target.getBoundingClientRect().top;
                    const offsetPosition = elementPosition + window.pageYOffset - headerOffset;

                    window.scrollTo({
                        top: offsetPosition,
                        behavior: 'smooth'
                    });
                }
            });
        });

        // Section animations
        const sectionObserver = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('visible');
                    
                    // Animate child elements with stagger effect
                    const staggerItems = entry.target.querySelectorAll('.stagger-item');
                    staggerItems.forEach(item => {
                        item.classList.add('visible');
                    });
                }
            });
        }, {
            threshold: 0.1,
            rootMargin: '0px 0px -10% 0px'
        });

        // Observe all sections with animation
        document.querySelectorAll('.section-animate').forEach(section => {
            sectionObserver.observe(section);
        });

        // Remove old animation observers if they exist
        const oldObservers = document.querySelectorAll('.animate, .fade-up');
        oldObservers.forEach(element => {
            element.classList.remove('animate', 'fade-up');
        });