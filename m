From: =?UTF-8?Q?Jan_Sebastian_G=c3=b6tte?= <linux@jaseg.net>
Date: Wed, 17 Jul 2019 14:41:37 +0000
Subject: [PATCH v2] Staging: fbtft: Fix GPIO handling
Message-Id: <75ada52f-afa1-08bc-d0ce-966fc1110e70@jaseg.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190715143003.12819-1-nsaenzjulienne@suse.de>
 <7b8242ab-cc0c-d90b-60af-ff1c53789e44@opensynergy.com>
 <5a77c18f-7338-888f-2379-12171b6a545e@jaseg.net>
In-Reply-To: <5a77c18f-7338-888f-2379-12171b6a545e@jaseg.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Jan_Sebastian_G=c3=b6tte?= <linux@jaseg.net>
Cc: devel@driverdev.osuosl.org, leobras.c@gmail.com, linux-fbdev@vger.kernel.org, nishadkamdar@gmail.com, gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org, bhanusreemahesh@gmail.com, Phil Reid <preid@electromag.com.au>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Commit c440eee1a7a1 ("Staging: fbtft: Switch to the gpio descriptor
interface") breaks GPIO handling. In several places, checks to only set
a GPIO if it was configured ended up backwards.
I have tested this fix. The fixed driver works with a ili9486
display connected to a raspberry pi via SPI.

Fixes: commit c440eee1a7a1d ("Staging: fbtft: Switch to the gpio descriptor=
 interface")
Tested-by: Jan Sebastian G=F6tte <linux@jaseg.net>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Jan Sebastian G=F6tte <linux@jaseg.net>
---
 drivers/staging/fbtft/fb_bd663474.c  | 2 +-
 drivers/staging/fbtft/fb_ili9163.c   | 2 +-
 drivers/staging/fbtft/fb_ili9325.c   | 2 +-
 drivers/staging/fbtft/fb_s6d1121.c   | 2 +-
 drivers/staging/fbtft/fb_ssd1289.c   | 2 +-
 drivers/staging/fbtft/fb_ssd1331.c   | 4 ++--
 drivers/staging/fbtft/fb_upd161704.c | 2 +-
 drivers/staging/fbtft/fbtft-bus.c    | 2 +-
 drivers/staging/fbtft/fbtft-core.c   | 4 ++--
 9 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/fbtft/fb_bd663474.c b/drivers/staging/fbtft/fb=
_bd663474.c
index b6c6d66e4eb1..e2c7646588f8 100644
--- a/drivers/staging/fbtft/fb_bd663474.c
+++ b/drivers/staging/fbtft/fb_bd663474.c
@@ -24,7 +24,7 @@
=20
 static int init_display(struct fbtft_par *par)
 {
-	if (!par->gpio.cs)
+	if (par->gpio.cs)
 		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
=20
 	par->fbtftops.reset(par);
diff --git a/drivers/staging/fbtft/fb_ili9163.c b/drivers/staging/fbtft/fb_=
ili9163.c
index d609a2b67db9..fd32376700e2 100644
--- a/drivers/staging/fbtft/fb_ili9163.c
+++ b/drivers/staging/fbtft/fb_ili9163.c
@@ -77,7 +77,7 @@ static int init_display(struct fbtft_par *par)
 {
 	par->fbtftops.reset(par);
=20
-	if (!par->gpio.cs)
+	if (par->gpio.cs)
 		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
=20
 	write_reg(par, MIPI_DCS_SOFT_RESET); /* software reset */
diff --git a/drivers/staging/fbtft/fb_ili9325.c b/drivers/staging/fbtft/fb_=
ili9325.c
index b090e7ab6fdd..85e54a10ed72 100644
--- a/drivers/staging/fbtft/fb_ili9325.c
+++ b/drivers/staging/fbtft/fb_ili9325.c
@@ -85,7 +85,7 @@ static int init_display(struct fbtft_par *par)
 {
 	par->fbtftops.reset(par);
=20
-	if (!par->gpio.cs)
+	if (par->gpio.cs)
 		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
=20
 	bt &=3D 0x07;
diff --git a/drivers/staging/fbtft/fb_s6d1121.c b/drivers/staging/fbtft/fb_=
s6d1121.c
index b3d0701880fe..5a129b1352cc 100644
--- a/drivers/staging/fbtft/fb_s6d1121.c
+++ b/drivers/staging/fbtft/fb_s6d1121.c
@@ -29,7 +29,7 @@ static int init_display(struct fbtft_par *par)
 {
 	par->fbtftops.reset(par);
=20
-	if (!par->gpio.cs)
+	if (par->gpio.cs)
 		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
=20
 	/* Initialization sequence from Lib_UTFT */
diff --git a/drivers/staging/fbtft/fb_ssd1289.c b/drivers/staging/fbtft/fb_=
ssd1289.c
index bbf75f795234..88a5b6925901 100644
--- a/drivers/staging/fbtft/fb_ssd1289.c
+++ b/drivers/staging/fbtft/fb_ssd1289.c
@@ -28,7 +28,7 @@ static int init_display(struct fbtft_par *par)
 {
 	par->fbtftops.reset(par);
=20
-	if (!par->gpio.cs)
+	if (par->gpio.cs)
 		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
=20
 	write_reg(par, 0x00, 0x0001);
diff --git a/drivers/staging/fbtft/fb_ssd1331.c b/drivers/staging/fbtft/fb_=
ssd1331.c
index 4cfe9f8535d0..37622c9462aa 100644
--- a/drivers/staging/fbtft/fb_ssd1331.c
+++ b/drivers/staging/fbtft/fb_ssd1331.c
@@ -81,7 +81,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int le=
n, ...)
 	va_start(args, len);
=20
 	*buf =3D (u8)va_arg(args, unsigned int);
-	if (!par->gpio.dc)
+	if (par->gpio.dc)
 		gpiod_set_value(par->gpio.dc, 0);
 	ret =3D par->fbtftops.write(par, par->buf, sizeof(u8));
 	if (ret < 0) {
@@ -104,7 +104,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int =
len, ...)
 			return;
 		}
 	}
-	if (!par->gpio.dc)
+	if (par->gpio.dc)
 		gpiod_set_value(par->gpio.dc, 1);
 	va_end(args);
 }
diff --git a/drivers/staging/fbtft/fb_upd161704.c b/drivers/staging/fbtft/f=
b_upd161704.c
index 564a38e34440..c77832ae5e5b 100644
--- a/drivers/staging/fbtft/fb_upd161704.c
+++ b/drivers/staging/fbtft/fb_upd161704.c
@@ -26,7 +26,7 @@ static int init_display(struct fbtft_par *par)
 {
 	par->fbtftops.reset(par);
=20
-	if (!par->gpio.cs)
+	if (par->gpio.cs)
 		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
=20
 	/* Initialization sequence from Lib_UTFT */
diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtf=
t-bus.c
index 2ea814d0dca5..63c65dd67b17 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -135,7 +135,7 @@ int fbtft_write_vmem16_bus8(struct fbtft_par *par, size=
_t offset, size_t len)
 	remain =3D len / 2;
 	vmem16 =3D (u16 *)(par->info->screen_buffer + offset);
=20
-	if (!par->gpio.dc)
+	if (par->gpio.dc)
 		gpiod_set_value(par->gpio.dc, 1);
=20
 	/* non buffered write */
diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbt=
ft-core.c
index bc750250ccd6..5127de922f6a 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -916,7 +916,7 @@ static int fbtft_init_display_dt(struct fbtft_par *par)
 		return -EINVAL;
=20
 	par->fbtftops.reset(par);
-	if (!par->gpio.cs)
+	if (par->gpio.cs)
 		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
=20
 	while (p) {
@@ -1007,7 +1007,7 @@ int fbtft_init_display(struct fbtft_par *par)
 	}
=20
 	par->fbtftops.reset(par);
-	if (!par->gpio.cs)
+	if (par->gpio.cs)
 		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
=20
 	i =3D 0;
--=20
2.21.0
