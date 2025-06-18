<?php
include "_functions.php";
require_once('_header.php'); 
$data = mysqli_query($koneksi, "SELECT * FROM laporan_harian ORDER BY tanggal DESC");
?>

<div class="container laporan-harian-container">
    <h3 class="laporan-harian-title">Laporan Harian</h3>
    <table class="laporan-harian-table">
        <thead>
            <tr>
                <th>No</th>
                <th>Tanggal</th>
                <th>Total Pendapatan</th>
            </tr>
        </thead>
        <tbody>
        <?php
        $no = 1;
        while ($row = mysqli_fetch_assoc($data)) {
            echo "<tr>
                    <td>{$no}</td>
                    <td>{$row['tanggal']}</td>
                    <td>Rp " . number_format($row['total_pendapatan'], 0, ',', '.') . "</td>
                  </tr>";
            $no++;
        }
        ?>
        </tbody>
    </table>
</div>

<?php require_once('_footer.php'); ?>