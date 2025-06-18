<?php
include "_functions.php";
require_once('_header.php'); 

// Query top 5 pelanggan
$top5_pelanggan = query("SELECT * FROM top5_pelanggan LIMIT 5");
?>
<style>
    .top5-table {
    width: 100%;
    max-width: 600px;
    margin: 40px auto 0 auto;
    border-collapse: collapse;
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 4px 24px rgba(0,0,0,0.08);
    overflow: hidden;
    font-size: 1.05rem;
}
.top5-table th, .top5-table td {
    padding: 14px 18px;
    text-align: left;
}
.top5-table th {
    background: #1e90ff;
    color: #fff;
    font-weight: 600;
    letter-spacing: 1px;
}
.top5-table tbody tr {
    transition: background 0.2s;
}
.top5-table tbody tr.top5-hover {
    background: #e6f2ff;
}
.top5-table tbody tr.top5-highlight {
    background: #ffe082;
    font-weight: bold;
}
.top5-table tbody tr:nth-child(even) {
    background: #f7faff;
}
.top5-table tbody tr:nth-child(odd) {
    background: #fff;
}
.top5-table td {
    border-bottom: 1px solid #e0e0e0;
}
.top5-table tbody tr:last-child td {
    border-bottom: none;
}

.container h2 {
    text-align: center;
    margin-top: 30px;
    color: #1e90ff;
    letter-spacing: 1px;
}
</style>

<div class="container">
    <h2>Top 5 Pelanggan dengan Pengeluaran Tertinggi</h2>
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
                <td><?= $no++; ?></td>
                <td><?= htmlspecialchars($row['nama']); ?></td>
                <td>Rp <?= number_format($row['total_pengeluaran'],0,',','.'); ?></td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</div>

<script src="_assets/js/top5.js"></script>

<?php
require_once('_footer.php'); 
?>

