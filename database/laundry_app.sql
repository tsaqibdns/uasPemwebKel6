-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 18, 2025 at 09:15 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `laundry_app`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `HitungPendapatanHarian` (IN `tgl` DATE)
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE total DOUBLE DEFAULT 0;
  DECLARE nominal DOUBLE DEFAULT 0;

  DECLARE cur CURSOR FOR
    SELECT tot_bayar FROM tb_order_ck WHERE tgl_masuk_ck = tgl
    UNION ALL
    SELECT tot_bayar FROM tb_order_cs WHERE tgl_masuk_cs = tgl
    UNION ALL
    SELECT tot_bayar FROM tb_order_dc WHERE tgl_masuk_dc = tgl;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur;

  read_loop: LOOP
    FETCH cur INTO nominal;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SET total = total + nominal;
  END LOOP;

  CLOSE cur;

  IF EXISTS (SELECT 1 FROM laporan_harian WHERE tanggal = tgl) THEN
    UPDATE laporan_harian SET total_pendapatan = total WHERE tanggal = tgl;
  ELSE
    INSERT INTO laporan_harian(tanggal, total_pendapatan)
    VALUES (tgl, total);
  END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `laporan_harian`
--

CREATE TABLE `laporan_harian` (
  `id_laporan` int(11) NOT NULL,
  `tanggal` date DEFAULT NULL,
  `total_pendapatan` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `master`
--

CREATE TABLE `master` (
  `id_user` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `level` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `master`
--

INSERT INTO `master` (`id_user`, `nama`, `email`, `username`, `password`, `level`) VALUES
(4, 'Admin', 'admin@mail.com', 'admin', '$2y$10$mi.Q/r6k5TFricaNcyr4y.3hm0qsFQeOWZEhXhJoN0h3W/bDQC/1m', 'Admin'),
(11, 'Karywan 1', 'karyawan1@mail.com', 'karyawan1', '$2y$10$rBG6s0gdPJDrNU9NXNxsAOGNIKDZAS..15cUo/i5xieIbcw2gxa1e', 'Karyawan');

-- --------------------------------------------------------

--
-- Table structure for table `tb_cuci_komplit`
--

CREATE TABLE `tb_cuci_komplit` (
  `id_ck` int(11) NOT NULL,
  `nama_paket_ck` varchar(100) NOT NULL,
  `waktu_kerja_ck` varchar(20) NOT NULL,
  `kuantitas_ck` int(11) NOT NULL,
  `tarif_ck` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_cuci_komplit`
--

INSERT INTO `tb_cuci_komplit` (`id_ck`, `nama_paket_ck`, `waktu_kerja_ck`, `kuantitas_ck`, `tarif_ck`) VALUES
(1, 'Cuci Komplit Reguler', '2 Hari', 1, 8000),
(2, 'Cuci Komplit Kilat', '1 Hari', 1, 15000),
(3, 'Cuci Komplit Express', '5 Jam', 1, 20000);

-- --------------------------------------------------------

--
-- Table structure for table `tb_cuci_satuan`
--

CREATE TABLE `tb_cuci_satuan` (
  `id_cs` int(11) NOT NULL,
  `nama_cs` varchar(100) NOT NULL,
  `waktu_kerja_cs` varchar(20) NOT NULL,
  `kuantitas_cs` int(11) NOT NULL,
  `tarif_cs` int(11) NOT NULL,
  `keterangan_cs` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_cuci_satuan`
--

INSERT INTO `tb_cuci_satuan` (`id_cs`, `nama_cs`, `waktu_kerja_cs`, `kuantitas_cs`, `tarif_cs`, `keterangan_cs`) VALUES
(1, 'Jaket Kulit', '1 Hari', 1, 15000, ''),
(2, 'Jaket Non Kulit', '1 Hari', 1, 6000, ''),
(3, 'Boneka Mini', '1 Hari', 1, 3000, ''),
(4, 'Boneka Kecil', '1 Hari', 1, 6000, ''),
(5, 'Boneka Sedang', '1 Hari', 1, 10000, ''),
(6, 'Boneka Besar', '1 Hari', 1, 20000, ''),
(7, 'Sejadah', '1 Hari', 1, 20000, ''),
(8, 'Selimut', '1 Hari', 1, 20000, ''),
(9, 'Keset', '1 Hari', 1, 20000, '');

-- --------------------------------------------------------

--
-- Table structure for table `tb_dry_clean`
--

CREATE TABLE `tb_dry_clean` (
  `id_dc` int(11) NOT NULL,
  `nama_paket_dc` varchar(100) NOT NULL,
  `waktu_kerja_dc` varchar(20) NOT NULL,
  `kuantitas_dc` int(11) NOT NULL,
  `tarif_dc` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_dry_clean`
--

INSERT INTO `tb_dry_clean` (`id_dc`, `nama_paket_dc`, `waktu_kerja_dc`, `kuantitas_dc`, `tarif_dc`) VALUES
(1, 'Cuci Kering Reguler', '2 Hari', 1, 6000),
(2, 'Cuci Kering Kilat', '1 Hari', 1, 9000),
(3, 'Cuci Kering Express', '5 Jam', 1, 15000);

-- --------------------------------------------------------

--
-- Table structure for table `tb_order_ck`
--

CREATE TABLE `tb_order_ck` (
  `id_order_ck` int(11) NOT NULL,
  `or_ck_number` varchar(10) DEFAULT NULL,
  `nama_pel_ck` varchar(100) NOT NULL,
  `no_telp_ck` char(13) NOT NULL,
  `alamat_ck` text NOT NULL,
  `jenis_paket_ck` varchar(100) NOT NULL,
  `wkt_krj_ck` varchar(30) DEFAULT NULL,
  `berat_qty_ck` int(11) NOT NULL,
  `harga_perkilo` int(11) DEFAULT NULL,
  `tgl_masuk_ck` date NOT NULL,
  `tgl_keluar_ck` date NOT NULL,
  `tot_bayar` double DEFAULT NULL,
  `keterangan_ck` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_order_ck`
--

INSERT INTO `tb_order_ck` (`id_order_ck`, `or_ck_number`, `nama_pel_ck`, `no_telp_ck`, `alamat_ck`, `jenis_paket_ck`, `wkt_krj_ck`, `berat_qty_ck`, `harga_perkilo`, `tgl_masuk_ck`, `tgl_keluar_ck`, `tot_bayar`, `keterangan_ck`) VALUES
(22, 'CK-6852666', 'Almas', '09098', 'jl cibiru', 'Cuci Komplit Reguler', '2 Hari', 2, 8000, '3000-02-10', '3000-02-11', 16000, 'antar');


-- --------------------------------------------------------

--
-- Table structure for table `tb_order_cs`
--

CREATE TABLE `tb_order_cs` (
  `id_order_cs` int(11) NOT NULL,
  `or_cs_number` varchar(10) NOT NULL,
  `nama_pel_cs` varchar(100) NOT NULL,
  `no_telp_cs` varchar(13) NOT NULL,
  `alamat_cs` text NOT NULL,
  `jenis_paket_cs` varchar(100) NOT NULL,
  `wkt_krj_cs` varchar(30) DEFAULT NULL,
  `jml_pcs` int(11) NOT NULL,
  `harga_perpcs` int(11) NOT NULL,
  `tgl_masuk_cs` date NOT NULL,
  `tgl_keluar_cs` date NOT NULL,
  `tot_bayar` double NOT NULL,
  `keterangan_cs` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_order_dc`
--

CREATE TABLE `tb_order_dc` (
  `id_order_dc` int(11) NOT NULL,
  `or_dc_number` varchar(10) NOT NULL,
  `nama_pel_dc` varchar(100) NOT NULL,
  `no_telp_dc` varchar(13) NOT NULL,
  `alamat_dc` text NOT NULL,
  `jenis_paket_dc` varchar(100) NOT NULL,
  `wkt_krj_dc` varchar(30) DEFAULT NULL,
  `berat_qty_dc` int(11) NOT NULL,
  `harga_perkilo` int(11) NOT NULL,
  `tgl_masuk_dc` date NOT NULL,
  `tgl_keluar_dc` date NOT NULL,
  `tot_bayar` double NOT NULL,
  `keterangan_dc` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_riwayat_ck`
--

CREATE TABLE `tb_riwayat_ck` (
  `id_ck` int(11) NOT NULL,
  `or_number` varchar(20) NOT NULL,
  `pelanggan` varchar(100) NOT NULL,
  `no_telp` char(15) NOT NULL,
  `alamat` text NOT NULL,
  `j_paket` varchar(50) NOT NULL,
  `wkt_kerja` varchar(20) NOT NULL,
  `berat` int(5) NOT NULL,
  `h_perkilo` int(11) NOT NULL,
  `tgl_msk` varchar(40) NOT NULL,
  `tgl_klr` varchar(40) NOT NULL,
  `total` int(11) NOT NULL,
  `nominal_byr` int(11) NOT NULL,
  `kembalian` int(11) NOT NULL,
  `status` varchar(20) NOT NULL,
  `keterangan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_riwayat_ck`
--

INSERT INTO `tb_riwayat_ck` (`id_ck`, `or_number`, `pelanggan`, `no_telp`, `alamat`, `j_paket`, `wkt_kerja`, `berat`, `h_perkilo`, `tgl_msk`, `tgl_klr`, `total`, `nominal_byr`, `kembalian`, `status`, `keterangan`) VALUES
(16, 'CK-63FF618', 'Adam', '081000111000', 'Ds. Suka Maju', 'Cuci Komplit Reguler', '2 Hari', 2, 8000, '28 Februari 2023', '01 Maret 2023', 16000, 20000, 4000, 'Sukses', '-'),
(17, 'CK-63FF621', 'Sischa', '082222000111', 'Ds. Suka Maju', 'Cuci Komplit Express', '5 Jam', 5, 20000, '01 Maret 2023', '01 Maret 2023', 100000, 100000, 0, 'Sukses', '-'),
(18, 'CK-63FF62C', 'Ayumi', '085555000555', 'Ds. Trihanggo', 'Cuci Komplit Reguler', '2 Hari', 3, 8000, '27 Februari 2023', '01 Maret 2023', 24000, 25000, 1000, 'Sukses', '-'),
(19, 'CK-6852530', 'Jilan', '9828934', 'dasd', 'Cuci Komplit Reguler', '2 Hari', 6, 8000, '10 Februari 2000', '11 Februari 2000', 48000, 50000, 2000, 'Sukses', 'sdasd'),
(20, 'CK-6852530', 'Jilan', '9828934', 'dasd', 'Cuci Komplit Reguler', '2 Hari', 6, 8000, '10 Februari 2000', '11 Februari 2000', 48000, 50000, 2000, 'Sukses', 'sdasd'),
(21, 'CK-63FF710', 'Jhone', '081000000001', 'Ds. Maju Bersama', 'Cuci Komplit Express', '5 Jam', 5, 20000, '01 Maret 2023', '01 Maret 2023', 100000, 200000, 100000, 'Sukses', '-'),
(22, 'CK-6852666', 'Almas', '09098', 'jl cibiru', 'Cuci Komplit Reguler', '2 Hari', 2, 8000, '10 February 3000', '11 February 3000', 16000, 16000, 0, 'Sukses', 'antar'),
(23, 'CK-6852666', 'Almas', '09098', 'jl cibiru', 'Cuci Komplit Reguler', '2 Hari', 2, 8000, '10 Februari 3000', '11 Februari 3000', 16000, 180000, 164000, 'Sukses', 'antar');

-- --------------------------------------------------------

--
-- Table structure for table `tb_riwayat_cs`
--

CREATE TABLE `tb_riwayat_cs` (
  `id_cs` int(11) NOT NULL,
  `or_number` varchar(20) DEFAULT NULL,
  `pelanggan` varchar(100) DEFAULT NULL,
  `no_telp` char(15) DEFAULT NULL,
  `alamat` text DEFAULT NULL,
  `j_paket` varchar(50) DEFAULT NULL,
  `wkt_kerja` varchar(20) DEFAULT NULL,
  `jml_pcs` int(11) DEFAULT NULL,
  `h_perpcs` int(11) DEFAULT NULL,
  `tgl_msk` varchar(40) DEFAULT NULL,
  `tgl_klr` varchar(40) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `nominal_byr` int(11) DEFAULT NULL,
  `kembalian` int(11) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `keterangan` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_riwayat_dc`
--

CREATE TABLE `tb_riwayat_dc` (
  `id_dc` int(11) NOT NULL,
  `or_number` varchar(20) DEFAULT NULL,
  `pelanggan` varchar(100) DEFAULT NULL,
  `no_telp` char(15) DEFAULT NULL,
  `alamat` text DEFAULT NULL,
  `j_paket` varchar(40) DEFAULT NULL,
  `wkt_kerja` varchar(20) DEFAULT NULL,
  `berat` int(11) DEFAULT NULL,
  `h_perkilo` int(11) DEFAULT NULL,
  `tgl_msk` varchar(40) DEFAULT NULL,
  `tgl_klr` varchar(40) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `nominal_byr` int(11) DEFAULT NULL,
  `kembalian` int(11) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `keterangan` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `top5_pelanggan`
-- (See below for the actual view)
--
CREATE TABLE `top5_pelanggan` (
`nama` varchar(100)
,`total_pengeluaran` double
);

-- --------------------------------------------------------

--
-- Structure for view `top5_pelanggan`
--
DROP TABLE IF EXISTS `top5_pelanggan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `top5_pelanggan`  AS SELECT `semua_order`.`nama` AS `nama`, sum(`semua_order`.`total`) AS `total_pengeluaran`FROM (select `tb_order_ck`.`nama_pel_ck` AS `nama`,`tb_order_ck`.`tot_bayar` AS `total` from `tb_order_ck` union all select `tb_order_cs`.`nama_pel_cs` AS `nama_pel_cs`,`tb_order_cs`.`tot_bayar` AS `tot_bayar` from `tb_order_cs` union all select `tb_order_dc`.`nama_pel_dc` AS `nama_pel_dc`,`tb_order_dc`.`tot_bayar` AS `tot_bayar` from `tb_order_dc`) AS `semua_order` GROUP BY `semua_order`.`nama` ORDER BY sum(`semua_order`.`total`) DESC LIMIT 0, 55  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `laporan_harian`
--
ALTER TABLE `laporan_harian`
  ADD PRIMARY KEY (`id_laporan`);

--
-- Indexes for table `master`
--
ALTER TABLE `master`
  ADD PRIMARY KEY (`id_user`);

--
-- Indexes for table `tb_cuci_komplit`
--
ALTER TABLE `tb_cuci_komplit`
  ADD PRIMARY KEY (`id_ck`);

--
-- Indexes for table `tb_cuci_satuan`
--
ALTER TABLE `tb_cuci_satuan`
  ADD PRIMARY KEY (`id_cs`);

--
-- Indexes for table `tb_dry_clean`
--
ALTER TABLE `tb_dry_clean`
  ADD PRIMARY KEY (`id_dc`);

--
-- Indexes for table `tb_order_ck`
--
ALTER TABLE `tb_order_ck`
  ADD PRIMARY KEY (`id_order_ck`);

--
-- Indexes for table `tb_order_cs`
--
ALTER TABLE `tb_order_cs`
  ADD PRIMARY KEY (`id_order_cs`);

--
-- Indexes for table `tb_order_dc`
--
ALTER TABLE `tb_order_dc`
  ADD PRIMARY KEY (`id_order_dc`);

--
-- Indexes for table `tb_riwayat_ck`
--
ALTER TABLE `tb_riwayat_ck`
  ADD PRIMARY KEY (`id_ck`);

--
-- Indexes for table `tb_riwayat_cs`
--
ALTER TABLE `tb_riwayat_cs`
  ADD PRIMARY KEY (`id_cs`);

--
-- Indexes for table `tb_riwayat_dc`
--
ALTER TABLE `tb_riwayat_dc`
  ADD PRIMARY KEY (`id_dc`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `laporan_harian`
--
ALTER TABLE `laporan_harian`
  MODIFY `id_laporan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `master`
--
ALTER TABLE `master`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `tb_cuci_komplit`
--
ALTER TABLE `tb_cuci_komplit`
  MODIFY `id_ck` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `tb_cuci_satuan`
--
ALTER TABLE `tb_cuci_satuan`
  MODIFY `id_cs` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `tb_dry_clean`
--
ALTER TABLE `tb_dry_clean`
  MODIFY `id_dc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tb_order_ck`
--
ALTER TABLE `tb_order_ck`
  MODIFY `id_order_ck` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `tb_order_cs`
--
ALTER TABLE `tb_order_cs`
  MODIFY `id_order_cs` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tb_order_dc`
--
ALTER TABLE `tb_order_dc`
  MODIFY `id_order_dc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tb_riwayat_ck`
--
ALTER TABLE `tb_riwayat_ck`
  MODIFY `id_ck` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `tb_riwayat_cs`
--
ALTER TABLE `tb_riwayat_cs`
  MODIFY `id_cs` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tb_riwayat_dc`
--
ALTER TABLE `tb_riwayat_dc`
  MODIFY `id_dc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
