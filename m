From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 4/16] rivafb: Driver cleanups
Date: Mon, 28 Nov 2005 23:17:30 +0800
Message-ID: <438B1F8A.7020801@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhGn8-00023V-3u
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 17:29:50 -0800
Received: from zproxy.gmail.com ([64.233.162.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EhGn7-000244-Jp
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 17:29:50 -0800
Received: by zproxy.gmail.com with SMTP id z3so2537390nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 29 Nov 2005 17:29:48 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

- remove redundant casts

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/riva/fbdev.c      |   44 ++++++++++++++++++++-------------------
 drivers/video/riva/rivafb-i2c.c |    8 ++++---
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
index 3e9f96e..dd7b2cc 100644
--- a/drivers/video/riva/fbdev.c
+++ b/drivers/video/riva/fbdev.c
@@ -630,7 +630,7 @@ static void riva_load_video_mode(struct 
 	int bpp, width, hDisplaySize, hDisplay, hStart,
 	    hEnd, hTotal, height, vDisplay, vStart, vEnd, vTotal, dotClock;
 	int hBlankStart, hBlankEnd, vBlankStart, vBlankEnd;
-	struct riva_par *par = (struct riva_par *) info->par;
+	struct riva_par *par = info->par;
 	struct riva_regs newmode;
 	
 	NVTRACE_ENTER();
@@ -925,7 +925,7 @@ riva_set_rop_solid(struct riva_par *par,
 
 static void riva_setup_accel(struct fb_info *info)
 {
-	struct riva_par *par = (struct riva_par *) info->par;
+	struct riva_par *par = info->par;
 
 	RIVA_FIFO_FREE(par->riva, Clip, 2);
 	NV_WR32(&par->riva.Clip->TopLeft, 0, 0x0);
@@ -979,7 +979,7 @@ static int riva_get_cmap_len(const struc
 #ifdef CONFIG_PMAC_BACKLIGHT
 static int riva_set_backlight_enable(int on, int level, void *data)
 {
-	struct riva_par *par = (struct riva_par *)data;
+	struct riva_par *par = data;
 	U032 tmp_pcrt, tmp_pmc;
 
 	tmp_pmc = par->riva.PMC[0x10F0/4] & 0x0000FFFF;
@@ -1008,7 +1008,7 @@ static int riva_set_backlight_level(int 
 
 static int rivafb_open(struct fb_info *info, int user)
 {
-	struct riva_par *par = (struct riva_par *) info->par;
+	struct riva_par *par = info->par;
 	int cnt = atomic_read(&par->ref_count);
 
 	NVTRACE_ENTER();
@@ -1034,7 +1034,7 @@ static int rivafb_open(struct fb_info *i
 
 static int rivafb_release(struct fb_info *info, int user)
 {
-	struct riva_par *par = (struct riva_par *) info->par;
+	struct riva_par *par = info->par;
 	int cnt = atomic_read(&par->ref_count);
 
 	NVTRACE_ENTER();
@@ -1057,7 +1057,7 @@ static int rivafb_release(struct fb_info
 static int rivafb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
 	struct fb_videomode *mode;
-	struct riva_par *par = (struct riva_par *) info->par;
+	struct riva_par *par = info->par;
 	int nom, den;		/* translating from pixels->bytes */
 	int mode_valid = 0;
 	
@@ -1166,7 +1166,7 @@ static int rivafb_check_var(struct fb_va
 
 static int rivafb_set_par(struct fb_info *info)
 {
-	struct riva_par *par = (struct riva_par *) info->par;
+	struct riva_par *par = info->par;
 
 	NVTRACE_ENTER();
 	/* vgaHWunlock() + riva unlock (0x7F) */
@@ -1205,7 +1205,7 @@ static int rivafb_set_par(struct fb_info
 static int rivafb_pan_display(struct fb_var_screeninfo *var,
 			      struct fb_info *info)
 {
-	struct riva_par *par = (struct riva_par *)info->par;
+	struct riva_par *par = info->par;
 	unsigned int base;
 
 	NVTRACE_ENTER();
@@ -1241,7 +1241,7 @@ static int rivafb_pan_display(struct fb_
 
 static int rivafb_blank(int blank, struct fb_info *info)
 {
-	struct riva_par *par= (struct riva_par *)info->par;
+	struct riva_par *par= info->par;
 	unsigned char tmp, vesa;
 
 	tmp = SEQin(par, 0x01) & ~0x20;	/* screen on/off */
@@ -1304,7 +1304,7 @@ static int rivafb_setcolreg(unsigned reg
 			  unsigned blue, unsigned transp,
 			  struct fb_info *info)
 {
-	struct riva_par *par = (struct riva_par *)info->par;
+	struct riva_par *par = info->par;
 	RIVA_HW_INST *chip = &par->riva;
 	int i;
 
@@ -1393,7 +1393,7 @@ static int rivafb_setcolreg(unsigned reg
  */
 static void rivafb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 {
-	struct riva_par *par = (struct riva_par *) info->par;
+	struct riva_par *par = info->par;
 	u_int color, rop = 0;
 
 	if ((info->flags & FBINFO_HWACCEL_DISABLED)) {
@@ -1449,7 +1449,7 @@ static void rivafb_fillrect(struct fb_in
  */
 static void rivafb_copyarea(struct fb_info *info, const struct fb_copyarea *region)
 {
-	struct riva_par *par = (struct riva_par *) info->par;
+	struct riva_par *par = info->par;
 
 	if ((info->flags & FBINFO_HWACCEL_DISABLED)) {
 		cfb_copyarea(info, region);
@@ -1495,7 +1495,7 @@ static inline void convert_bgcolor_16(u3
 static void rivafb_imageblit(struct fb_info *info, 
 			     const struct fb_image *image)
 {
-	struct riva_par *par = (struct riva_par *) info->par;
+	struct riva_par *par = info->par;
 	u32 fgx = 0, bgx = 0, width, tmp;
 	u8 *cdat = (u8 *) image->data;
 	volatile u32 __iomem *d;
@@ -1580,7 +1580,7 @@ static void rivafb_imageblit(struct fb_i
  */
 static int rivafb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
-	struct riva_par *par = (struct riva_par *) info->par;
+	struct riva_par *par = info->par;
 	u8 data[MAX_CURS * MAX_CURS/8];
 	int i, set = cursor->set;
 	u16 fg, bg;
@@ -1664,7 +1664,7 @@ static int rivafb_cursor(struct fb_info 
 
 static int rivafb_sync(struct fb_info *info)
 {
-	struct riva_par *par = (struct riva_par *)info->par;
+	struct riva_par *par = info->par;
 
 	wait_for_idle(par);
 	return 0;
@@ -1696,7 +1696,7 @@ static struct fb_ops riva_fb_ops = {
 static int __devinit riva_set_fbinfo(struct fb_info *info)
 {
 	unsigned int cmap_len;
-	struct riva_par *par = (struct riva_par *) info->par;
+	struct riva_par *par = info->par;
 
 	NVTRACE_ENTER();
 	info->flags = FBINFO_DEFAULT
@@ -1733,7 +1733,7 @@ static int __devinit riva_set_fbinfo(str
 #ifdef CONFIG_PPC_OF
 static int __devinit riva_get_EDID_OF(struct fb_info *info, struct pci_dev *pd)
 {
-	struct riva_par *par = (struct riva_par *) info->par;
+	struct riva_par *par = info->par;
 	struct device_node *dp;
 	unsigned char *pedid = NULL;
 	unsigned char *disptype = NULL;
@@ -1767,7 +1767,7 @@ static int __devinit riva_get_EDID_OF(st
 #if defined(CONFIG_FB_RIVA_I2C) && !defined(CONFIG_PPC_OF)
 static int __devinit riva_get_EDID_i2c(struct fb_info *info)
 {
-	struct riva_par *par = (struct riva_par *) info->par;
+	struct riva_par *par = info->par;
 	struct fb_var_screeninfo var;
 	int i;
 
@@ -1837,7 +1837,7 @@ static void __devinit riva_get_EDID(stru
 static void __devinit riva_get_edidinfo(struct fb_info *info)
 {
 	struct fb_var_screeninfo *var = &rivafb_default_var;
-	struct riva_par *par = (struct riva_par *) info->par;
+	struct riva_par *par = info->par;
 
 	fb_edid_to_monspecs(par->EDID, &info->monspecs);
 	fb_videomode_to_modelist(info->monspecs.modedb, info->monspecs.modedb_len,
@@ -1909,7 +1909,7 @@ static int __devinit rivafb_probe(struct
 		ret = -ENOMEM;
 		goto err_ret;
 	}
-	default_par = (struct riva_par *) info->par;
+	default_par = info->par;
 	default_par->pdev = pd;
 
 	info->pixmap.addr = kmalloc(8 * 1024, GFP_KERNEL);
@@ -2070,7 +2070,7 @@ static int __devinit rivafb_probe(struct
 
 err_iounmap_screen_base:
 #ifdef CONFIG_FB_RIVA_I2C
-	riva_delete_i2c_busses((struct riva_par *) info->par);
+	riva_delete_i2c_busses(info->par);
 #endif
 	iounmap(info->screen_base);
 err_iounmap_pramin:
@@ -2093,7 +2093,7 @@ err_ret:
 static void __exit rivafb_remove(struct pci_dev *pd)
 {
 	struct fb_info *info = pci_get_drvdata(pd);
-	struct riva_par *par = (struct riva_par *) info->par;
+	struct riva_par *par = info->par;
 	
 	NVTRACE_ENTER();
 	if (!info)
diff --git a/drivers/video/riva/rivafb-i2c.c b/drivers/video/riva/rivafb-i2c.c
index 77151d8..8b1967f 100644
--- a/drivers/video/riva/rivafb-i2c.c
+++ b/drivers/video/riva/rivafb-i2c.c
@@ -30,7 +30,7 @@
 
 static void riva_gpio_setscl(void* data, int state)
 {
-	struct riva_i2c_chan 	*chan = (struct riva_i2c_chan *)data;
+	struct riva_i2c_chan 	*chan = data;
 	struct riva_par 	*par = chan->par;
 	u32			val;
 
@@ -48,7 +48,7 @@ static void riva_gpio_setscl(void* data,
 
 static void riva_gpio_setsda(void* data, int state)
 {
-	struct riva_i2c_chan 	*chan = (struct riva_i2c_chan *)data;
+	struct riva_i2c_chan 	*chan = data;
 	struct riva_par 	*par = chan->par;
 	u32			val;
 
@@ -66,7 +66,7 @@ static void riva_gpio_setsda(void* data,
 
 static int riva_gpio_getscl(void* data)
 {
-	struct riva_i2c_chan 	*chan = (struct riva_i2c_chan *)data;
+	struct riva_i2c_chan 	*chan = data;
 	struct riva_par 	*par = chan->par;
 	u32			val = 0;
 
@@ -81,7 +81,7 @@ static int riva_gpio_getscl(void* data)
 
 static int riva_gpio_getsda(void* data)
 {
-	struct riva_i2c_chan 	*chan = (struct riva_i2c_chan *)data;
+	struct riva_i2c_chan 	*chan = data;
 	struct riva_par 	*par = chan->par;
 	u32			val = 0;
 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
