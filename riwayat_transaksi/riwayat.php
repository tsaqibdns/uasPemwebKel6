<?php 
   require_once('../_header.php');
   $query_ck = query("SELECT * FROM tb_riwayat_ck ORDER BY id_ck DESC");
   $query_dc = query("SELECT * FROM tb_riwayat_dc ORDER BY id_dc DESC");
   $query_cs = query("SELECT * FROM tb_riwayat_cs ORDER BY id_cs DESC");
?>

<div class="riwayat main-content">
  <div class="container">
    <div class="baris">
      <div class="selamat-datang">
        <div class="col-header">
          <h2 class="judul-md">Daftar Riwayat Transaksi</h2>
        </div>
      </div>
    </div>

    <div class="baris">
      <ul class="order-tabs enhanced-tabs">
        <li><a href="#" class="tab-link active" data-tab="ck"><img src="<?=url('_assets/img/cuci_komplit.png')?>" alt="Cuci Komplit" class="tab-icon"> Cuci Komplit</a></li>
        <li><a href="#" class="tab-link" data-tab="dc"><img src="<?=url('_assets/img/dry_clean.png')?>" alt="Dry Clean" class="tab-icon"> Cuci Kering/Dry Clean</a></li>
        <li><a href="#" class="tab-link" data-tab="cs"><img src="<?=url('_assets/img/kemeja_2.png')?>" alt="Cuci Satuan" class="tab-icon"> Cuci Satuan</a></li>
      </ul>
    </div>

    <div class="baris">
      <div id="tab-ck" class="tab-content" style="display:block;">
        <?php require_once('riwayat_ck/riwayat_ck.php') ?>
      </div>
      <div id="tab-dc" class="tab-content" style="display:none;">
        <?php require_once('riwayat_dc/riwayat_dc.php') ?>
      </div>
      <div id="tab-cs" class="tab-content" style="display:none;">
        <?php require_once('riwayat_cs/riwayat_cs.php') ?>
      </div>
    </div>
  </div>
</div>

<?php require_once('../_footer.php') ?>