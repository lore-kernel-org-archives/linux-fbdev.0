Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C8334A793;
	Fri, 13 Feb 2026 08:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770973189; cv=none; b=lbvuycH/QwuHE8is0/8wy8SQGn+VF/8EQni8wT+G7WJwPDPeOe//RFHI1Q8ImjPoLm1R3NfrwZi7KyqcsbZ4j5NY5SkSi2+r9xQSoN5iqq5r/FxUdTio58i8g7mY9acuN/cyib4DrG6MmCfJ4X9iLHYKa5bDEkxmB7mmizb3DjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770973189; c=relaxed/simple;
	bh=mJTbsaYejs2QKv5LcDMB0GXa6sC5yRDPm/PY8lOTIFs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=sD9NuYVS+o0z9CZXwWNOHS8LzeP2o/Kgnxzt3w5M6tt6hK5ACgJs7K1npADglGtEZZxzMsOz81+tWubvGyQI7D99sdtOWWBoOLxh1vLlzO+GC58vcYOyvST0l0eHqARMtiIohTF32gGxO/qvViJkPGGNii85u3t7mUpLWBBv/N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D0bLBkfG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lkNFznFq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D0bLBkfG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lkNFznFq"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770973186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4brwSYakET9Bm4Iocm0LcclnipEpthhqMy3QtgSzwGQ=;
	b=D0bLBkfG9AQCkvHNphSGXD5o+m+M8PD+ugR95wY1nQ17jn8XJ8gT6hKCUBRWB+86aWUaLI
	bsrkEEbXgfAUVgKOQWUssQiDF+7RRSbho7D8iG7TLDax9vc95CGc+8K1pPs05Ll5ba76T4
	HCUSNmr79XSW+NK0QUtFKbH1XZWj6xY/GToOz0LJIdTISuwhL/uvc1ix8VuxqOB4QIeTq4
	1u10dgCMTQUoftO3pQ2NRDqhyUQlaKHY8UI5PMR1Z1FBeN1MPE3RTx8a7YPW3Nu2iPW/Hj
	LGl9kAj/DJZNbmH6342zKY5AAEvGSVbt0pAXFK5PDpSEMX1FDzmim6qVVIu7IA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770973186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4brwSYakET9Bm4Iocm0LcclnipEpthhqMy3QtgSzwGQ=;
	b=lkNFznFqzyj7vCQ0gtWCZWB+s0h2Hbyd0cNvXhcDU+pNj/TATW/5GAEfihmjd9t2PsBzgy
	Tz1OfKzg8RvX86Bw==
To: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nam Cao <namcao@linutronix.de>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fbtft: Remove duplications of fbtft_set_addr_win()
Date: Fri, 13 Feb 2026 09:59:27 +0100
Message-ID: <20260213085927.3673653-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Lots of drivers duplicate the default fbtft_set_addr_win(). Just use the
default instead.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 drivers/staging/fbtft/fb_hx8340bn.c |  8 --------
 drivers/staging/fbtft/fb_hx8353d.c  | 13 -------------
 drivers/staging/fbtft/fb_hx8357d.c  | 14 --------------
 drivers/staging/fbtft/fb_ili9340.c  | 12 ------------
 drivers/staging/fbtft/fb_ili9341.c  | 12 ------------
 drivers/staging/fbtft/fb_ili9481.c  | 12 ------------
 drivers/staging/fbtft/fb_ili9486.c  | 12 ------------
 drivers/staging/fbtft/fb_s6d02a1.c  | 12 ------------
 drivers/staging/fbtft/fb_st7735r.c  | 12 ------------
 drivers/staging/fbtft/fb_tinylcd.c  | 12 ------------
 10 files changed, 119 deletions(-)

diff --git a/drivers/staging/fbtft/fb_hx8340bn.c b/drivers/staging/fbtft/fb=
_hx8340bn.c
index 2fd7b87ea0ce..ca27914f1412 100644
--- a/drivers/staging/fbtft/fb_hx8340bn.c
+++ b/drivers/staging/fbtft/fb_hx8340bn.c
@@ -106,13 +106,6 @@ static int init_display(struct fbtft_par *par)
 	return 0;
 }
=20
-static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, in=
t ye)
-{
-	write_reg(par, MIPI_DCS_SET_COLUMN_ADDRESS, 0x00, xs, 0x00, xe);
-	write_reg(par, MIPI_DCS_SET_PAGE_ADDRESS, 0x00, ys, 0x00, ye);
-	write_reg(par, MIPI_DCS_WRITE_MEMORY_START);
-}
-
 static int set_var(struct fbtft_par *par)
 {
 	/* MADCTL - Memory data access control */
@@ -207,7 +200,6 @@ static struct fbtft_display display =3D {
 	.gamma =3D DEFAULT_GAMMA,
 	.fbtftops =3D {
 		.init_display =3D init_display,
-		.set_addr_win =3D set_addr_win,
 		.set_var =3D set_var,
 		.set_gamma =3D set_gamma,
 	},
diff --git a/drivers/staging/fbtft/fb_hx8353d.c b/drivers/staging/fbtft/fb_=
hx8353d.c
index 3e73b69b6a27..f6cd82df4da6 100644
--- a/drivers/staging/fbtft/fb_hx8353d.c
+++ b/drivers/staging/fbtft/fb_hx8353d.c
@@ -61,18 +61,6 @@ static int init_display(struct fbtft_par *par)
 	return 0;
 };
=20
-static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, in=
t ye)
-{
-	/* column address */
-	write_reg(par, 0x2a, xs >> 8, xs & 0xff, xe >> 8, xe & 0xff);
-
-	/* Row address */
-	write_reg(par, 0x2b, ys >> 8, ys & 0xff, ye >> 8, ye & 0xff);
-
-	/* memory write */
-	write_reg(par, 0x2c);
-}
-
 #define my BIT(7)
 #define mx BIT(6)
 #define mv BIT(5)
@@ -130,7 +118,6 @@ static struct fbtft_display display =3D {
 	.gamma =3D DEFAULT_GAMMA,
 	.fbtftops =3D {
 		.init_display =3D init_display,
-		.set_addr_win =3D set_addr_win,
 		.set_var =3D set_var,
 		.set_gamma =3D set_gamma,
 	},
diff --git a/drivers/staging/fbtft/fb_hx8357d.c b/drivers/staging/fbtft/fb_=
hx8357d.c
index 94a357e8fdf6..7b9f020a956f 100644
--- a/drivers/staging/fbtft/fb_hx8357d.c
+++ b/drivers/staging/fbtft/fb_hx8357d.c
@@ -129,19 +129,6 @@ static int init_display(struct fbtft_par *par)
 	return 0;
 }
=20
-static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, in=
t ye)
-{
-	write_reg(par, MIPI_DCS_SET_COLUMN_ADDRESS,
-		  xs >> 8, xs & 0xff,  /* XSTART */
-		  xe >> 8, xe & 0xff); /* XEND */
-
-	write_reg(par, MIPI_DCS_SET_PAGE_ADDRESS,
-		  ys >> 8, ys & 0xff,  /* YSTART */
-		  ye >> 8, ye & 0xff); /* YEND */
-
-	write_reg(par, MIPI_DCS_WRITE_MEMORY_START);
-}
-
 #define HX8357D_MADCTL_MY  0x80
 #define HX8357D_MADCTL_MX  0x40
 #define HX8357D_MADCTL_MV  0x20
@@ -184,7 +171,6 @@ static struct fbtft_display display =3D {
 	.gamma_len =3D 14,
 	.fbtftops =3D {
 		.init_display =3D init_display,
-		.set_addr_win =3D set_addr_win,
 		.set_var =3D set_var,
 	},
 };
diff --git a/drivers/staging/fbtft/fb_ili9340.c b/drivers/staging/fbtft/fb_=
ili9340.c
index 704236bcaf3f..023d8cb96f95 100644
--- a/drivers/staging/fbtft/fb_ili9340.c
+++ b/drivers/staging/fbtft/fb_ili9340.c
@@ -78,17 +78,6 @@ static int init_display(struct fbtft_par *par)
 	return 0;
 }
=20
-static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, in=
t ye)
-{
-	write_reg(par, MIPI_DCS_SET_COLUMN_ADDRESS,
-		  xs >> 8, xs & 0xFF, xe >> 8, xe & 0xFF);
-
-	write_reg(par, MIPI_DCS_SET_PAGE_ADDRESS,
-		  ys >> 8, ys & 0xFF, ye >> 8, ye & 0xFF);
-
-	write_reg(par, MIPI_DCS_WRITE_MEMORY_START);
-}
-
 #define ILI9340_MADCTL_MV  0x20
 #define ILI9340_MADCTL_MX  0x40
 #define ILI9340_MADCTL_MY  0x80
@@ -122,7 +111,6 @@ static struct fbtft_display display =3D {
 	.height =3D HEIGHT,
 	.fbtftops =3D {
 		.init_display =3D init_display,
-		.set_addr_win =3D set_addr_win,
 		.set_var =3D set_var,
 	},
 };
diff --git a/drivers/staging/fbtft/fb_ili9341.c b/drivers/staging/fbtft/fb_=
ili9341.c
index 47e72b87d76d..428922dee9f9 100644
--- a/drivers/staging/fbtft/fb_ili9341.c
+++ b/drivers/staging/fbtft/fb_ili9341.c
@@ -65,17 +65,6 @@ static int init_display(struct fbtft_par *par)
 	return 0;
 }
=20
-static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, in=
t ye)
-{
-	write_reg(par, MIPI_DCS_SET_COLUMN_ADDRESS,
-		  (xs >> 8) & 0xFF, xs & 0xFF, (xe >> 8) & 0xFF, xe & 0xFF);
-
-	write_reg(par, MIPI_DCS_SET_PAGE_ADDRESS,
-		  (ys >> 8) & 0xFF, ys & 0xFF, (ye >> 8) & 0xFF, ye & 0xFF);
-
-	write_reg(par, MIPI_DCS_WRITE_MEMORY_START);
-}
-
 #define MEM_Y   BIT(7) /* MY row address order */
 #define MEM_X   BIT(6) /* MX column address order */
 #define MEM_V   BIT(5) /* MV row / column exchange */
@@ -139,7 +128,6 @@ static struct fbtft_display display =3D {
 	.gamma =3D DEFAULT_GAMMA,
 	.fbtftops =3D {
 		.init_display =3D init_display,
-		.set_addr_win =3D set_addr_win,
 		.set_var =3D set_var,
 		.set_gamma =3D set_gamma,
 	},
diff --git a/drivers/staging/fbtft/fb_ili9481.c b/drivers/staging/fbtft/fb_=
ili9481.c
index 19eba085ea53..5f31b5d5590f 100644
--- a/drivers/staging/fbtft/fb_ili9481.c
+++ b/drivers/staging/fbtft/fb_ili9481.c
@@ -42,17 +42,6 @@ static const s16 default_init_sequence[] =3D {
 	-3
 };
=20
-static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, in=
t ye)
-{
-	write_reg(par, MIPI_DCS_SET_COLUMN_ADDRESS,
-		  xs >> 8, xs & 0xff, xe >> 8, xe & 0xff);
-
-	write_reg(par, MIPI_DCS_SET_PAGE_ADDRESS,
-		  ys >> 8, ys & 0xff, ye >> 8, ye & 0xff);
-
-	write_reg(par, MIPI_DCS_WRITE_MEMORY_START);
-}
-
 #define HFLIP 0x01
 #define VFLIP 0x02
 #define ROW_X_COL 0x20
@@ -86,7 +75,6 @@ static struct fbtft_display display =3D {
 	.height =3D HEIGHT,
 	.init_sequence =3D default_init_sequence,
 	.fbtftops =3D {
-		.set_addr_win =3D set_addr_win,
 		.set_var =3D set_var,
 	},
 };
diff --git a/drivers/staging/fbtft/fb_ili9486.c b/drivers/staging/fbtft/fb_=
ili9486.c
index 66210a7137fc..a4d699ef57e4 100644
--- a/drivers/staging/fbtft/fb_ili9486.c
+++ b/drivers/staging/fbtft/fb_ili9486.c
@@ -43,17 +43,6 @@ static const s16 default_init_sequence[] =3D {
 	-3
 };
=20
-static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, in=
t ye)
-{
-	write_reg(par, MIPI_DCS_SET_COLUMN_ADDRESS,
-		  xs >> 8, xs & 0xFF, xe >> 8, xe & 0xFF);
-
-	write_reg(par, MIPI_DCS_SET_PAGE_ADDRESS,
-		  ys >> 8, ys & 0xFF, ye >> 8, ye & 0xFF);
-
-	write_reg(par, MIPI_DCS_WRITE_MEMORY_START);
-}
-
 static int set_var(struct fbtft_par *par)
 {
 	switch (par->info->var.rotate) {
@@ -86,7 +75,6 @@ static struct fbtft_display display =3D {
 	.height =3D HEIGHT,
 	.init_sequence =3D default_init_sequence,
 	.fbtftops =3D {
-		.set_addr_win =3D set_addr_win,
 		.set_var =3D set_var,
 	},
 };
diff --git a/drivers/staging/fbtft/fb_s6d02a1.c b/drivers/staging/fbtft/fb_=
s6d02a1.c
index d3d6871d8c47..d8ddc804d626 100644
--- a/drivers/staging/fbtft/fb_s6d02a1.c
+++ b/drivers/staging/fbtft/fb_s6d02a1.c
@@ -97,17 +97,6 @@ static const s16 default_init_sequence[] =3D {
=20
 };
=20
-static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, in=
t ye)
-{
-	write_reg(par, MIPI_DCS_SET_COLUMN_ADDRESS,
-		  xs >> 8, xs & 0xFF, xe >> 8, xe & 0xFF);
-
-	write_reg(par, MIPI_DCS_SET_PAGE_ADDRESS,
-		  ys >> 8, ys & 0xFF, ye >> 8, ye & 0xFF);
-
-	write_reg(par, MIPI_DCS_WRITE_MEMORY_START);
-}
-
 #define MY BIT(7)
 #define MX BIT(6)
 #define MV BIT(5)
@@ -149,7 +138,6 @@ static struct fbtft_display display =3D {
 	.height =3D 160,
 	.init_sequence =3D default_init_sequence,
 	.fbtftops =3D {
-		.set_addr_win =3D set_addr_win,
 		.set_var =3D set_var,
 	},
 };
diff --git a/drivers/staging/fbtft/fb_st7735r.c b/drivers/staging/fbtft/fb_=
st7735r.c
index 9670a8989b91..6d9735fa2332 100644
--- a/drivers/staging/fbtft/fb_st7735r.c
+++ b/drivers/staging/fbtft/fb_st7735r.c
@@ -83,17 +83,6 @@ static const s16 default_init_sequence[] =3D {
 	-3
 };
=20
-static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, in=
t ye)
-{
-	write_reg(par, MIPI_DCS_SET_COLUMN_ADDRESS,
-		  xs >> 8, xs & 0xFF, xe >> 8, xe & 0xFF);
-
-	write_reg(par, MIPI_DCS_SET_PAGE_ADDRESS,
-		  ys >> 8, ys & 0xFF, ye >> 8, ye & 0xFF);
-
-	write_reg(par, MIPI_DCS_WRITE_MEMORY_START);
-}
-
 #define MY BIT(7)
 #define MX BIT(6)
 #define MV BIT(5)
@@ -168,7 +157,6 @@ static struct fbtft_display display =3D {
 	.gamma_len =3D 16,
 	.gamma =3D DEFAULT_GAMMA,
 	.fbtftops =3D {
-		.set_addr_win =3D set_addr_win,
 		.set_var =3D set_var,
 		.set_gamma =3D set_gamma,
 	},
diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_=
tinylcd.c
index 9469248f2c50..fc17e3c687fb 100644
--- a/drivers/staging/fbtft/fb_tinylcd.c
+++ b/drivers/staging/fbtft/fb_tinylcd.c
@@ -47,17 +47,6 @@ static int init_display(struct fbtft_par *par)
 	return 0;
 }
=20
-static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, in=
t ye)
-{
-	write_reg(par, MIPI_DCS_SET_COLUMN_ADDRESS,
-		  xs >> 8, xs & 0xFF, xe >> 8, xe & 0xFF);
-
-	write_reg(par, MIPI_DCS_SET_PAGE_ADDRESS,
-		  ys >> 8, ys & 0xFF, ye >> 8, ye & 0xFF);
-
-	write_reg(par, MIPI_DCS_WRITE_MEMORY_START);
-}
-
 static int set_var(struct fbtft_par *par)
 {
 	switch (par->info->var.rotate) {
@@ -88,7 +77,6 @@ static struct fbtft_display display =3D {
 	.height =3D HEIGHT,
 	.fbtftops =3D {
 		.init_display =3D init_display,
-		.set_addr_win =3D set_addr_win,
 		.set_var =3D set_var,
 	},
 };
--=20
2.47.3

