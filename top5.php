<?php
include "_functions.php";
require_once('_header.php'); 

// Query top 5 pelanggan
$top5_pelanggan = query("SELECT * FROM top5_pelanggan LIMIT 5");
?>

<div class="container top5-container">
    <h2 class="top5-title">Top 5 Pelanggan dengan Pengeluaran Tertinggi</h2>
    <table class="top5-table" border="0" cellpadding="10" cellspacing="0">
        <thead>
            <tr>
                <th>No</th>
                <th>Nama Pelanggan</th>
                <th>Total Pengeluaran</th>
            </tr>
        </thead>
        <tbody>
            <?php $no = 1; foreach($top5_pelanggan as $row): ?>
            <tr>
                <td data-label="No"><?= $no++; ?></td>
                <td data-label="Nama Pelanggan"><?= htmlspecialchars($row['nama']); ?></td>
                <td data-label="Total Pengeluaran">Rp <?= number_format($row['total_pengeluaran'],0,',','.'); ?></td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</div>

<script src="_assets/js/top5.js"></script>

<?php
require_once('_footer.php'); 
?>

