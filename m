From: Lars Svensson <lars1.svensson@sonymobile.com>
Date: Wed, 07 Oct 2015 07:20:13 +0000
Subject: [PATCH v3 2/3] staging: fbtft: use alternate screen pointer
Message-Id: <1444202414-21271-2-git-send-email-lars1.svensson@sonymobile.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1444202414-21271-1-git-send-email-lars1.svensson@sonymobile.com>
In-Reply-To: <1444202414-21271-1-git-send-email-lars1.svensson@sonymobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: thomas.petazzoni@free-electrons.com, noralf@tronnes.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, dan.carpenter@oracle.com, Lars Svensson <lars1.svensson@sonymobile.com>

Member screen_base in struct fb_info is declared with __iomem
qualifier causing sparse warnings when used as a regular ponter.
To avoid the warnings, instead use alternate non-__iomem pointer,
screen_buffer, troughout the driver.

Signed-off-by: Lars Svensson <lars1.svensson@sonymobile.com>
---
 drivers/staging/fbtft/fb_agm1264k-fl.c | 2 +-
 drivers/staging/fbtft/fb_pcd8544.c     | 2 +-
 drivers/staging/fbtft/fb_ra8875.c      | 2 +-
 drivers/staging/fbtft/fb_ssd1306.c     | 2 +-
 drivers/staging/fbtft/fb_tls8204.c     | 2 +-
 drivers/staging/fbtft/fb_uc1611.c      | 2 +-
 drivers/staging/fbtft/fb_uc1701.c      | 2 +-
 drivers/staging/fbtft/fb_watterott.c   | 4 ++--
 drivers/staging/fbtft/fbtft-bus.c      | 6 +++---
 drivers/staging/fbtft/fbtft-core.c     | 4 ++--
 10 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/fbtft/fb_agm1264k-fl.c b/drivers/staging/fbtft/fb_agm1264k-fl.c
index 94dd49c..5af372b 100644
--- a/drivers/staging/fbtft/fb_agm1264k-fl.c
+++ b/drivers/staging/fbtft/fb_agm1264k-fl.c
@@ -273,7 +273,7 @@ construct_line_bitmap(struct fbtft_par *par, u8 *dest, signed short *src,
 
 static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 {
-	u16 *vmem16 = (u16 *)par->info->screen_base;
+	u16 *vmem16 = (u16 *)par->info->screen_buffer;
 	u8 *buf = par->txbuf.buf;
 	int x, y;
 	int ret = 0;
diff --git a/drivers/staging/fbtft/fb_pcd8544.c b/drivers/staging/fbtft/fb_pcd8544.c
index 15da0ec..27d6681 100644
--- a/drivers/staging/fbtft/fb_pcd8544.c
+++ b/drivers/staging/fbtft/fb_pcd8544.c
@@ -122,7 +122,7 @@ static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, int ye)
 
 static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 {
-	u16 *vmem16 = (u16 *)par->info->screen_base;
+	u16 *vmem16 = (u16 *)par->info->screen_buffer;
 	u8 *buf = par->txbuf.buf;
 	int x, y, i;
 	int ret = 0;
diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb_ra8875.c
index 54bc566..e8b2178 100644
--- a/drivers/staging/fbtft/fb_ra8875.c
+++ b/drivers/staging/fbtft/fb_ra8875.c
@@ -288,7 +288,7 @@ static int write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
 		__func__, offset, len);
 
 	remain = len / 2;
-	vmem16 = (u16 *)(par->info->screen_base + offset);
+	vmem16 = (u16 *)(par->info->screen_buffer + offset);
 	tx_array_size = par->txbuf.len / 2;
 		txbuf16 = (u16 *)(par->txbuf.buf + 1);
 		tx_array_size -= 2;
diff --git a/drivers/staging/fbtft/fb_ssd1306.c b/drivers/staging/fbtft/fb_ssd1306.c
index 15ee44d..913b0f7 100644
--- a/drivers/staging/fbtft/fb_ssd1306.c
+++ b/drivers/staging/fbtft/fb_ssd1306.c
@@ -172,7 +172,7 @@ static int set_gamma(struct fbtft_par *par, unsigned long *curves)
 
 static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 {
-	u16 *vmem16 = (u16 *)par->info->screen_base;
+	u16 *vmem16 = (u16 *)par->info->screen_buffer;
 	u8 *buf = par->txbuf.buf;
 	int x, y, i;
 	int ret = 0;
diff --git a/drivers/staging/fbtft/fb_tls8204.c b/drivers/staging/fbtft/fb_tls8204.c
index 3253a25..b66dc7f 100644
--- a/drivers/staging/fbtft/fb_tls8204.c
+++ b/drivers/staging/fbtft/fb_tls8204.c
@@ -104,7 +104,7 @@ static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, int ye)
 
 static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 {
-	u16 *vmem16 = (u16 *)par->info->screen_base;
+	u16 *vmem16 = (u16 *)par->info->screen_buffer;
 	int x, y, i;
 	int ret = 0;
 
diff --git a/drivers/staging/fbtft/fb_uc1611.c b/drivers/staging/fbtft/fb_uc1611.c
index 5cafa50..689a56a 100644
--- a/drivers/staging/fbtft/fb_uc1611.c
+++ b/drivers/staging/fbtft/fb_uc1611.c
@@ -229,7 +229,7 @@ static int set_var(struct fbtft_par *par)
 
 static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 {
-	u8 *vmem8 = (u8 *)(par->info->screen_base);
+	u8 *vmem8 = (u8 *)(par->info->screen_buffer);
 	u8 *buf8 = (u8 *)(par->txbuf.buf);
 	u16 *buf16 = (u16 *)(par->txbuf.buf);
 	int line_length = par->info->fix.line_length;
diff --git a/drivers/staging/fbtft/fb_uc1701.c b/drivers/staging/fbtft/fb_uc1701.c
index 26d669b..96b7298 100644
--- a/drivers/staging/fbtft/fb_uc1701.c
+++ b/drivers/staging/fbtft/fb_uc1701.c
@@ -150,7 +150,7 @@ static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, int ye)
 
 static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 {
-	u16 *vmem16 = (u16 *)par->info->screen_base;
+	u16 *vmem16 = (u16 *)par->info->screen_buffer;
 	u8 *buf = par->txbuf.buf;
 	int x, y, i;
 	int ret = 0;
diff --git a/drivers/staging/fbtft/fb_watterott.c b/drivers/staging/fbtft/fb_watterott.c
index 8eae6ef..ed88e2d 100644
--- a/drivers/staging/fbtft/fb_watterott.c
+++ b/drivers/staging/fbtft/fb_watterott.c
@@ -73,7 +73,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 {
 	unsigned start_line, end_line;
-	u16 *vmem16 = (u16 *)(par->info->screen_base + offset);
+	u16 *vmem16 = (u16 *)(par->info->screen_buffer + offset);
 	u16 *pos = par->txbuf.buf + 1;
 	u16 *buf16 = par->txbuf.buf + 10;
 	int i, j;
@@ -112,7 +112,7 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 static int write_vmem_8bit(struct fbtft_par *par, size_t offset, size_t len)
 {
 	unsigned start_line, end_line;
-	u16 *vmem16 = (u16 *)(par->info->screen_base + offset);
+	u16 *vmem16 = (u16 *)(par->info->screen_buffer + offset);
 	u16 *pos = par->txbuf.buf + 1;
 	u8 *buf8 = par->txbuf.buf + 10;
 	int i, j;
diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 912c632..f5a36a4 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -142,7 +142,7 @@ int fbtft_write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
 		__func__, offset, len);
 
 	remain = len / 2;
-	vmem16 = (u16 *)(par->info->screen_base + offset);
+	vmem16 = (u16 *)(par->info->screen_buffer + offset);
 
 	if (par->gpio.dc != -1)
 		gpio_set_value(par->gpio.dc, 1);
@@ -201,7 +201,7 @@ int fbtft_write_vmem16_bus9(struct fbtft_par *par, size_t offset, size_t len)
 	}
 
 	remain = len;
-	vmem8 = par->info->screen_base + offset;
+	vmem8 = par->info->screen_buffer + offset;
 
 	tx_array_size = par->txbuf.len / 2;
 
@@ -245,7 +245,7 @@ int fbtft_write_vmem16_bus16(struct fbtft_par *par, size_t offset, size_t len)
 	fbtft_par_dbg(DEBUG_WRITE_VMEM, par, "%s(offset=%zu, len=%zu)\n",
 		__func__, offset, len);
 
-	vmem16 = (u16 *)(par->info->screen_base + offset);
+	vmem16 = (u16 *)(par->info->screen_buffer + offset);
 
 	if (par->gpio.dc != -1)
 		gpio_set_value(par->gpio.dc, 1);
diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 7f5fa3d..a5fade2 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -779,7 +779,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	if (!info)
 		goto alloc_fail;
 
-	info->screen_base = (u8 __force __iomem *)vmem;
+	info->screen_buffer = vmem;
 	info->fbops = fbops;
 	info->fbdefio = fbdefio;
 
@@ -919,7 +919,7 @@ EXPORT_SYMBOL(fbtft_framebuffer_alloc);
 void fbtft_framebuffer_release(struct fb_info *info)
 {
 	fb_deferred_io_cleanup(info);
-	vfree(info->screen_base);
+	vfree(info->screen_buffer);
 	framebuffer_release(info);
 }
 EXPORT_SYMBOL(fbtft_framebuffer_release);
-- 
2.4.2

