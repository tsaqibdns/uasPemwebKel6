<?php 
	require_once('_header.php'); 
	if (isset($_SESSION['login']) == '') {
		header("Location: login.php");
		exit();
	}
	$jml_karyawan = count(query('SELECT * FROM master LIMIT 20 OFFSET 1'));
?>

	<div id="main" class="main-content">
		<div class="container">
			<div class="baris">
				<div class="selamat-datang">
					<div class="col-header">
						<p class="judul-sm">Selamat Datang <span><?= ucfirst($_SESSION['master']) ?></span></p>
						<h2 class="judul-md">Dashboard</h2>
					</div>

					<div class="col-header txt-right">
						<a href="<?=url('order/order.php')?>" class="btn-lg bg-primary">+ Order Baru</a>
					</div>	
				</div>
			</div>

			<div class="baris">
				<div class="col col-4">
					<div class="card">
						<div class="card-body">
							<div class="card-panel">
								<div class="panel-header">
									<p>Total Order</p>
									<h2><?= jmlOrder(); ?></h2>
								</div>
								
								<div class="panel-icon">
									<img src="<?=url('_assets/img/total_order.png')?>" alt="order" height="48">
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="col col-4">
					<div class="card">
						<div class="card-body">
							<div class="card-panel">
								<div class="panel-header">
									<p>Jumlah Paket Tersedia</p>
									<h2><?= jmlPaket(); ?></h2>
								</div>

								<div class="panel-icon">
									<img src="<?=url('_assets/img/jumlah_paket.png')?>" alt="paket" height="48">
								</div>
							</div>
							
						</div>
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
					<?php require_once('daftar_order/daf_or_ck.php');?>
				</div>
				<div id="tab-dc" class="tab-content" style="display:none;">
					<?php require_once('daftar_order/daf_or_dc.php');?>
				</div>
				<div id="tab-cs" class="tab-content" style="display:none;">
					<?php require_once('daftar_order/daf_or_cs.php');?>
				</div>
			</div>
		</div>
	</div>

<?php require_once('_footer.php'); ?>