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

// Intersection Observer for animations
const observerOptions = {
    threshold: 0.1
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            if (!entry.target.classList.contains('stat-item')) {
                entry.target.classList.add('animate');
            }
        }
    });
}, observerOptions);

// Number animation
function animateValue(element, start, end, duration) {
    console.log('Starting animation:', { element, start, end, duration });
    let startTimestamp = null;
    const step = (timestamp) => {
        if (!startTimestamp) startTimestamp = timestamp;
        const progress = Math.min((timestamp - startTimestamp) / duration, 1);
        const current = Math.floor(progress * (end - start) + start);
        element.textContent = current + '%';
        if (progress < 1) {
            window.requestAnimationFrame(step);
        } else {
            console.log('Animation finished for:', end);
        }
    };
    window.requestAnimationFrame(step);
}

// Stats animation observer
const statsObserver = new IntersectionObserver((entries) => {
    console.log('Observer triggered:', entries.length, 'entries');
    entries.forEach(entry => {
        console.log('Entry:', entry.isIntersecting, entry.target);
        if (entry.isIntersecting) {
            const statNumber = entry.target.querySelector('.stat-number');
            console.log('Found stat number:', statNumber);
            if (statNumber && statNumber.dataset.animated !== 'true') {
                const target = parseInt(statNumber.dataset.target);
                console.log('Starting animation for target:', target);
                statNumber.dataset.animated = 'true';
                animateValue(statNumber, 0, target, 600);
            }
        }
    });
}, { 
    threshold: 0.1,
    rootMargin: '0px' 
});

// Make sure DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    console.log('DOM loaded, setting up observers');
    const statItems = document.querySelectorAll('.stat-item');
    console.log('Found stat items:', statItems.length);
    statItems.forEach(item => {
        console.log('Observing item:', item);
        statsObserver.observe(item);
    });

    // Overlay logic for tech cards
    const overlay = document.getElementById('tech-overlay');
    const overlayIcon = overlay.querySelector('.tech-overlay-icon');
    const overlayTitle = overlay.querySelector('.tech-overlay-title');
    const overlayDesc = overlay.querySelector('.tech-overlay-description');
    const overlayClose = overlay.querySelector('.tech-overlay-close');

    // Helper: get icon HTML from card
    function getIconHTML(card) {
        const iconDiv = card.querySelector('.tech-icon');
        return iconDiv ? iconDiv.innerHTML : '';
    }

    // Show overlay with card info
    document.querySelectorAll('.tech-card').forEach(card => {
        card.addEventListener('click', function(e) {
            // Prevent link click (for GitHub card)
            if (e.target.closest('a')) return;
            overlayIcon.innerHTML = getIconHTML(card);
            overlayTitle.textContent = card.querySelector('.tech-title').textContent;
            // Use .tech-overlay-custom if present, else fallback
            const custom = card.querySelector('.tech-overlay-custom');
            if (custom) {
                overlayDesc.innerHTML = custom.innerHTML;
            } else {
                const overlayText = card.getAttribute('data-overlay') || card.querySelector('.tech-description').textContent;
                overlayDesc.textContent = overlayText;
            }
            overlay.style.display = 'flex';
            document.body.style.overflow = 'hidden';
        });
    });

    // Close overlay
    function closeOverlay() {
        overlay.style.display = 'none';
        document.body.style.overflow = '';
    }
    overlayClose.addEventListener('click', closeOverlay);
    overlay.addEventListener('click', function(e) {
        if (e.target === overlay) closeOverlay();
    });

    // Custom smooth scroll for anchor links
    function customSmoothScrollTo(targetY, duration = 800) {
        const startY = window.pageYOffset;
        const diff = targetY - startY;
        let startTime = null;
        function step(timestamp) {
            if (!startTime) startTime = timestamp;
            const progress = Math.min((timestamp - startTime) / duration, 1);
            const ease = 0.5 - Math.cos(progress * Math.PI) / 2; // easeInOut
            window.scrollTo(0, startY + diff * ease);
            if (progress < 1) {
                window.requestAnimationFrame(step);
            }
        }
        window.requestAnimationFrame(step);
    }
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            const href = this.getAttribute('href');
            if (href.length > 1 && document.querySelector(href)) {
                e.preventDefault();
                const target = document.querySelector(href);
                const headerOffset = 80;
                const elementPosition = target.getBoundingClientRect().top;
                const offsetPosition = elementPosition + window.pageYOffset - headerOffset;
                customSmoothScrollTo(offsetPosition, 800);
            }
        });
    });

    // Smooth scroll to top when clicking the logo
    document.querySelectorAll('.logo').forEach(logo => {
        logo.addEventListener('click', function(e) {
            e.preventDefault();
            customSmoothScrollTo(0, 800);
        });
    });
});

// Additional animation for offering cards
document.querySelectorAll('.offering-card, .testimonial-card').forEach(item => {
    observer.observe(item);
});

// Enhanced Mobile Menu Functionality
const mobileMenuButton = document.querySelector('.mobile-menu-button');
const mobileMenu = document.querySelector('.mobile-menu');
const mobileMenuClose = document.querySelector('.mobile-menu-close');
const mobileNavLinks = document.querySelectorAll('.mobile-nav-link');
let isMenuOpen = false;

function toggleMenu(open) {
    isMenuOpen = open;
    if (open) {
        mobileMenu.classList.add('active');
        document.body.style.overflow = 'hidden';
        // Animate menu items
        mobileNavLinks.forEach((link, index) => {
            link.style.transitionDelay = `${0.1 + index * 0.1}s`;
        });
    } else {
        mobileMenu.classList.remove('active');
        document.body.style.overflow = '';
        // Reset transition delays
        mobileNavLinks.forEach(link => {
            link.style.transitionDelay = '0s';
        });
    }
}

mobileMenuButton.addEventListener('click', () => {
    toggleMenu(true);
});

mobileMenuClose.addEventListener('click', () => {
    toggleMenu(false);
});

// Close menu when clicking outside
mobileMenu.addEventListener('click', (e) => {
    if (e.target === mobileMenu) {
        toggleMenu(false);
    }
});

// Close menu when pressing Escape
document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape' && isMenuOpen) {
        toggleMenu(false);
    }
});

// Close menu when clicking a link
mobileNavLinks.forEach(link => {
    link.addEventListener('click', () => {
        toggleMenu(false);
    });
});

// Header scroll effect
const header = document.querySelector('.header');

window.addEventListener('scroll', () => {
    if (window.scrollY > window.innerHeight * 0.9) {
        header.classList.add('scrolled');
    } else {
        header.classList.remove('scrolled');
    }
});

// Initialize header state
if (window.scrollY > window.innerHeight * 0.7) {
    header.classList.add('scrolled');
}

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
