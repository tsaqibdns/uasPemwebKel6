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

			<script>
				document.querySelectorAll('.tab-link').forEach(function(tab) {
					tab.addEventListener('click', function(e) {
						e.preventDefault();
						document.querySelectorAll('.tab-link').forEach(function(t) {
							t.classList.remove('active');
						});
						this.classList.add('active');
						const tabId = this.getAttribute('data-tab');
						document.querySelectorAll('.tab-content').forEach(function(content) {
							content.style.display = 'none';
						});
						document.getElementById('tab-' + tabId).style.display = 'block';
					});
				});
			</script>

			<!-- Enhanced Tab Styles -->
			<style>
				.enhanced-tabs {
					list-style: none;
					padding: 0;
					margin: 0 0 20px 0;
					display: flex;
					gap: 16px;
					justify-content: flex-start;
				}
				.enhanced-tabs li {
					margin: 0;
				}
				.tab-link {
					display: flex;
					align-items: center;
					gap: 8px;
					padding: 12px 28px;
					background: linear-gradient(90deg, #f8fafc 0%, #e9ecef 100%);
					color: #333;
					text-decoration: none;
					border-radius: 8px 8px 0 0;
					border: 1px solid #e0e0e0;
					border-bottom: none;
					transition: background 0.2s, color 0.2s, box-shadow 0.2s;
					box-shadow: 0 2px 6px rgba(0,0,0,0.03);
					font-size: 1.08em;
					font-weight: 500;
				}
				.tab-link .tab-icon {
					width: 22px;
					height: 22px;
					object-fit: contain;
					margin-right: 6px;
				}
				.tab-link.active {
					background: #fff;
					color: #007bff;
					border-bottom: 2px solid #fff;
					font-weight: bold;
					box-shadow: 0 4px 12px rgba(0,123,255,0.07);
				}
				.tab-link:hover:not(.active) {
					background: #f1f7ff;
					color: #0056b3;
				}
				.tab-content {
					border: 1px solid #e0e0e0;
					padding: 28px 24px;
					background: #fff;
					border-radius: 0 8px 8px 8px;
					box-shadow: 0 2px 8px rgba(0,0,0,0.04);
					animation: fadeIn 0.3s;
				}
				@keyframes fadeIn {
					from { opacity: 0; transform: translateY(10px);}
					to { opacity: 1; transform: translateY(0);}
				}
			</style>

		</div>
	</div>

<?php require_once('_footer.php'); ?>