// Animasi baris tabel saat hover dan highlight baris pertama
document.addEventListener('DOMContentLoaded', function() {
    const rows = document.querySelectorAll('.top5-table tbody tr');
    if(rows.length > 0) {
        rows[0].classList.add('top5-highlight');
    }
    rows.forEach(row => {
        row.addEventListener('mouseenter', function() {
            this.classList.add('top5-hover');
        });
        row.addEventListener('mouseleave', function() {
            this.classList.remove('top5-hover');
        });
    });
});
