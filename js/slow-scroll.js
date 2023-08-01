// Smooth scrolling for anchor links
const navLinks = document.querySelectorAll('nav a');

for (const link of navLinks) {
    link.addEventListener('click', smoothScroll);
}

function smoothScroll(event) {
    event.preventDefault();
    const targetId = this.getAttribute('href');
    const targetSection = document.querySelector(targetId);
    const navbarHeight = document.querySelector('nav').offsetHeight;
    const offsetTop = targetSection.getBoundingClientRect().top;
    const totalOffset = offsetTop - navbarHeight;

    window.scrollBy({
        top: totalOffset,
        behavior: 'smooth',
    });
}
