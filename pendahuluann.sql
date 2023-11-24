create table customer (
	id_customer CHAR(6) PRIMARY KEY,
	nama_customer VARCHAR(100) NOT NULL
);
CREATE TABLE membership(
	id_membership CHAR(6) PRIMARY KEY,
	no_telp_customer VARCHAR(15) NOT NULL,
	alamat_customer VARCHAR(150) DEFAULT NULL,
	tanggal_pembuatan DATE DEFAULT NULL,
	tanggal_kedaluwarsa DATE DEFAULT NULL,
	total_poin INT NOT NULL,
	m_id_customer CHAR(6) NOT NULL,
	FOREIGN KEY (m_id_customer) REFERENCES customer(id_customer) ON UPDATE CASCADE
);
CREATE TABLE menu_minuman(
	id_minuman CHAR(6) PRIMARY KEY,
	nama_minuman VARCHAR(50) NOT NULL,
	harga_minuman FLOAT NOT NULL
);
CREATE TABLE pegawai(
	nik CHAR(16) PRIMARY KEY,
	nama_pegawai VARCHAR(100) NOT NULL,
	jenis_kelamin CHAR(1) DEFAULT NULL,
	email VARCHAR(50) DEFAULT NULL,
	umur INT NOT NULL,
	telepon VARCHAR(15) NOT NULL
);
CREATE TABLE transaksi(
	id_transaksi CHAR(10) PRIMARY KEY,
	tanggal_transaksi DATE NOT NULL,
	metode_pembayaran VARCHAR(15) NOT NULL,
	customer_id_customer CHAR(6) NOT NULL,
	pegawai_nik CHAR(16) NOT NULL,
	FOREIGN KEY (customer_id_customer) REFERENCES customer(id_customer) ON UPDATE CASCADE,
	FOREIGN KEY (pegawai_nik) REFERENCES pegawai(nik)
);
CREATE TABLE transaksi_minuman(
	tm_menu_minuman_id CHAR(6) not null,
	tm_transaksi_id CHAR(10) NOT NULL,
	jumlah_minuman INT NOT NULL,
	FOREIGN KEY (tm_transaksi_id) REFERENCES transaksi(id_transaksi)
);
alter table transaksi_minuman
	ADD PRIMARY KEY (tm_menu_minuman_id, tm_transaksi_id);
drop table transaksi_minuman;
INSERT INTO customer (id_customer, nama_customer) VALUES
('CTR001', 'Budi Santoso'),
('CTR002', 'Sisil Triana'),
('CTR003', 'Davi Liam'),
('CTR004', 'Sutris Ten An'),
('CTR005', 'Hendra Asto');
INSERT INTO membership (id_membership, no_telp_customer, alamat_customer, tanggal_pembuatan, tanggal_kedaluwarsa, total_poin, m_id_customer) VALUES
('MBR001', '08123456789', 'Jl. Imam Bonjol', '2023-10-24', '2023-11-30', 0, 'CTR001'),
('MBR002', '0812345678', 'Jl. Kelinci', '2023-10-24', '2023-11-30', 0, 'CTR002'),
('MBR003', '081234567890', 'Jl. Abah Ojak', '2023-10-25', '2023-12-01', 2, 'CTR003'),
('MBR004', '08987654321', 'Jl. Kenangan', '2023-10-26', '2023-12-02', 6, 'CTR005');
INSERT INTO menu_minuman (id_minuman, nama_minuman, harga_minuman) VALUES
('MNM001', 'Expresso', 18000),
('MNM002', 'Cappucino', 20000),
('MNM003', 'Latte', 21000),
('MNM004', 'Americano', 19000),
('MNM005', 'Mocha', 22000),
('MNM006', 'Macchiato', 23000),
('MNM007', 'Cold Brew', 21000),
('MNM008', 'Iced Coffe', 18000),
('MNM009', 'Affogato', 23000),
('MNM010', 'Coffe Frappe', 22000);
INSERT INTO pegawai (nik, nama_pegawai, jenis_kelamin, email, umur, telepon) VALUES
('1111222233334444', 'Maimunah', 'P', 'maimunah@gmail.com', 25, '621234567'),
('1234567890123456', 'Naufal Raf', 'L', 'naufal@gmail.com', 19, '62123456789'),
('2345678901234561', 'Surinala', 'P', 'surinala@gmail.com', 24, '621234567890'),
('3456789012345612', 'Ben John', 'L', 'benjohn@gmail.com', 22, '6212345678');
INSERT INTO transaksi (id_transaksi, tanggal_transaksi, metode_pembayaran, customer_id_customer, pegawai_nik) VALUES
('TRX0000001', '2023-10-01', 'Kartu kredit', 'CTR002', '2345678901234561'),
('TRX0000002', '2023-10-03', 'Transfer bank', 'CTR004', '3456789012345612'),
('TRX0000003', '2023-10-05', 'Tunai', 'CTR001', '3456789012345612'),
('TRX0000004', '2023-10-15', 'Kartu debit', 'CTR003', '1234567890123456'),
('TRX0000005', '2023-10-15', 'E-wallet', 'CTR004', '1234567890123456'),
('TRX0000006', '2023-10-21', 'Tunai', 'CTR001', '2345678901234561'),
('TRX0000007', '2023-10-03', 'Transfer bank', 'CTR004', '2345678901234561');
INSERT INTO transaksi_minuman (tm_menu_minuman_id, tm_transaksi_id, jumlah_minuman) VALUES
('MNM001', 'TRX0000003', 3),
('MNM001', 'TRX0000005', 1),
('MNM003', 'TRX0000002', 2),
('MNM003', 'TRX0000003', 1),
('MNM003', 'TRX0000006', 2),
('MNM004', 'TRX0000004', 2),
('MNM005', 'TRX0000002', 1),
('MNM005', 'TRX0000007', 1),
('MNM006', 'TRX0000005', 2),
('MNM007', 'TRX0000001', 1),
('MNM009', 'TRX0000005', 1),
('MNM010', 'TRX0000001', 1),
('MNM010', 'TRX0000004', 1);

--number 1
select * from Transaksi 
	where Tanggal_transaksi between '2023-10-10' and '2023-10-20';
	
--number 2
select transaksi.id_transaksi, (menu_minuman.harga_minuman * transaksi_minuman.jumlah_minuman) as TOTAL_HARGA
	from transaksi_minuman 
	join transaksi on transaksi_minuman.tm_transaksi_id = transaksi.id_transaksi
	join menu_minuman on transaksi_minuman.tm_menu_minuman_id = menu_minuman.id_minuman;

--number 3
select customer.id_customer, customer.nama_customer, 
	sum(menu_minuman.harga_minuman * transaksi_minuman.jumlah_minuman) 
	as Total_belanja
	from transaksi 
	join transaksi_minuman on transaksi.id_transaksi = transaksi_minuman.tm_transaksi_id
	join menu_minuman on transaksi_minuman.tm_menu_minuman_id = menu_minuman.id_minuman
	join customer on transaksi.customer_id_customer = customer.id_customer
	where transaksi.Tanggal_transaksi between '2023-10-03' and '2023-10-22'
	group by customer.id_customer, customer.nama_customer
	order by customer.nama_customer asc;
	
--number 4
select pegawai.nik, pegawai.nama_pegawai, customer.nama_customer, transaksi.id_transaksi
	from customer
	join transaksi on customer.id_customer = transaksi.customer_id_customer
	join pegawai on transaksi.pegawai_nik = pegawai.nik
	where customer.nama_customer in ('Davi Liam', 'Sisil Triana', 'Hendra Asto');
	
--number 5
select extract(month from transaksi.tanggal_transaksi) as bulan, 
	extract(year from transaksi.tanggal_transaksi) as tahun, 
	sum(transaksi_minuman.jumlah_minuman) as cup
	from transaksi
	join transaksi_minuman on transaksi.id_transaksi = transaksi_minuman.tm_transaksi_id
	group by bulan, tahun
	order by bulan desc, tahun asc;
	
--number 6
select sum(menu_minuman.harga_minuman * transaksi_minuman.jumlah_minuman)/4 
	as Ratarata_tb
	from transaksi 
	join transaksi_minuman on transaksi.id_transaksi = transaksi_minuman.tm_transaksi_id
	join menu_minuman on transaksi_minuman.tm_menu_minuman_id = menu_minuman.id_minuman
	join customer on transaksi.customer_id_customer = customer.id_customer;

--number 7 option a
select customer.id_customer, customer.nama_customer, 
	sum(menu_minuman.harga_minuman * transaksi_minuman.jumlah_minuman) as tb_satuan,
	case
		when sum(menu_minuman.harga_minuman * transaksi_minuman.jumlah_minuman)/4 > 
		sum(menu_minuman.harga_minuman * transaksi_minuman.jumlah_minuman) then 'rata rata is bigger'
		else 'satuan is bigger'
	end as comparison_result
	from transaksi 
	join transaksi_minuman on transaksi.id_transaksi = transaksi_minuman.tm_transaksi_id
	join menu_minuman on transaksi_minuman.tm_menu_minuman_id = menu_minuman.id_minuman
	join customer on transaksi.customer_id_customer = customer.id_customer
	group by customer.id_customer, customer.nama_customer;
	
--number 7 option b
select sum(menu_minuman.harga_minuman * transaksi_minuman.jumlah_minuman)/4 as Ratarata_tb, 
	sum(menu_minuman.harga_minuman * transaksi_minuman.jumlah_minuman) as tb_satuan,
	case
		when sum(menu_minuman.harga_minuman * transaksi_minuman.jumlah_minuman)/4 > 
		sum(menu_minuman.harga_minuman * transaksi_minuman.jumlah_minuman) then 'rata rata is bigger'
		else 'satuan is bigger'
	end as comparison_result
	from transaksi 
	join transaksi_minuman on transaksi.id_transaksi = transaksi_minuman.tm_transaksi_id
	join menu_minuman on transaksi_minuman.tm_menu_minuman_id = menu_minuman.id_minuman
	join customer on transaksi.customer_id_customer = customer.id_customer;

--number 8
select customer.*
	from customer
	left join membership on customer.id_customer = membership.m_id_customer
	where membership.m_id_customer is null;

--number 9
select count(transaksi.customer_id_customer)
	from transaksi_minuman 
	join transaksi on transaksi_minuman.tm_transaksi_id = transaksi.id_transaksi
	join customer on transaksi.customer_id_customer = customer.id_customer
	join menu_minuman on transaksi_minuman.tm_menu_minuman_id = menu_minuman.id_minuman
	where menu_minuman.nama_minuman = 'Latte'
	group by transaksi.customer_id_customer;

--number 10
select customer.nama_customer, menu_minuman.nama_minuman, transaksi_minuman.jumlah_minuman
	from customer
	join transaksi on customer.id_customer = transaksi.customer_id_customer
	join transaksi_minuman on transaksi.id_transaksi = transaksi_minuman.tm_transaksi_id
	join menu_minuman on transaksi_minuman.tm_menu_minuman_id = menu_minuman.id_minuman
	where nama_customer like 'S%';