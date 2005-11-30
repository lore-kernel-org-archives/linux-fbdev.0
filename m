From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH RESEND] sstfb: Driver cleanups
Date: Wed, 30 Nov 2005 13:36:54 +0800
Message-ID: <438D3A76.5030604@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhKfM-0007IF-Qr
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 21:38:04 -0800
Received: from zproxy.gmail.com ([64.233.162.197])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EhKfK-00070J-1t
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 21:38:04 -0800
Received: by zproxy.gmail.com with SMTP id 4so973342nzn
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 29 Nov 2005 21:38:01 -0800 (PST)
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
To: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Ghozlane Toumi <gtoumi@laposte.net>

- remove unneeded casts
- make setcolreg return success if regno > 15, but don't do anything
- use framebuffer_alloc/framebuffer_release to allocate/free memory

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

The second copy of the concatenated patch was actually the correct
one :-)

 drivers/video/sstfb.c |   60 ++++++++++++++++++++++---------------------------
 include/video/sstfb.h |    1 +
 2 files changed, 28 insertions(+), 33 deletions(-)

diff --git a/drivers/video/sstfb.c b/drivers/video/sstfb.c
index e0f14df..8a5ce21 100644
--- a/drivers/video/sstfb.c
+++ b/drivers/video/sstfb.c
@@ -382,7 +382,7 @@ static void sstfb_clear_screen(struct fb
 static int sstfb_check_var(struct fb_var_screeninfo *var,
 		struct fb_info *info)
 {
-	struct sstfb_par *par = (struct sstfb_par *) info->par;
+	struct sstfb_par *par = info->par;
 	int hSyncOff   = var->xres + var->right_margin + var->left_margin;
 	int vSyncOff   = var->yres + var->lower_margin + var->upper_margin;
 	int vBackPorch = var->left_margin, yDim = var->yres;
@@ -542,7 +542,7 @@ static int sstfb_check_var(struct fb_var
  */
 static int sstfb_set_par(struct fb_info *info)
 {
-	struct sstfb_par *par = (struct sstfb_par *) info->par;
+	struct sstfb_par *par = info->par;
 	u32 lfbmode, fbiinit1, fbiinit2, fbiinit3, fbiinit5, fbiinit6=0;
 	struct pci_dev *sst_dev = par->dev;
 	unsigned int freq;
@@ -748,13 +748,14 @@ static int sstfb_set_par(struct fb_info 
 static int sstfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
                            u_int transp, struct fb_info *info)
 {
+	struct sstfb_par *par = info->par;
 	u32 col;
 
 	f_dddprintk("sstfb_setcolreg\n");
 	f_dddprintk("%-2d rgbt: %#x, %#x, %#x, %#x\n",
 	            regno, red, green, blue, transp);
-	if (regno >= 16)
-		return -EINVAL;
+	if (regno > 15)
+		return 0;
 
 	red    >>= (16 - info->var.red.length);
 	green  >>= (16 - info->var.green.length);
@@ -765,7 +766,7 @@ static int sstfb_setcolreg(u_int regno, 
 	    | (blue  << info->var.blue.offset)
 	    | (transp << info->var.transp.offset);
 	
-	((u32 *)info->pseudo_palette)[regno] = col;
+	par->palette[regno] = col;
 
 	return 0;
 }
@@ -773,7 +774,7 @@ static int sstfb_setcolreg(u_int regno, 
 static int sstfb_ioctl(struct inode *inode, struct file *file,
                        u_int cmd, u_long arg, struct fb_info *info )
 {
-	struct sstfb_par *par = (struct sstfb_par *) info->par;
+	struct sstfb_par *par = info->par;
 	struct pci_dev *sst_dev = par->dev;
 	u32 fbiinit0, tmp, val;
 	u_long p;
@@ -830,7 +831,7 @@ static int sstfb_ioctl(struct inode *ino
 #if 0
 static void sstfb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
 {
-	struct sstfb_par *par = (struct sstfb_par *) info->par;
+	struct sstfb_par *par = info->par;
 	u32 stride = info->fix.line_length;
    
 	if (!IS_VOODOO2(par))
@@ -855,7 +856,7 @@ static void sstfb_copyarea(struct fb_inf
  */
 static void sstfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect) 
 {
-	struct sstfb_par *par = (struct sstfb_par *) info->par;
+	struct sstfb_par *par = info->par;
 	u32 stride = info->fix.line_length;
 
 	if (!IS_VOODOO2(par))
@@ -925,7 +926,7 @@ static int __devinit sst_get_memsize(str
 
 static int __devinit sst_detect_att(struct fb_info *info)
 {
-	struct sstfb_par *par = (struct sstfb_par *) info->par;
+	struct sstfb_par *par = info->par;
 	int i, mir, dir;
 
 	for (i=0; i<3; i++) {
@@ -950,7 +951,7 @@ static int __devinit sst_detect_att(stru
 
 static int __devinit sst_detect_ti(struct fb_info *info)
 {
-	struct sstfb_par *par = (struct sstfb_par *) info->par;
+	struct sstfb_par *par = info->par;
 	int i, mir, dir;
 
 	for (i = 0; i<3; i++) {
@@ -986,7 +987,7 @@ static int __devinit sst_detect_ti(struc
  */
 static int __devinit sst_detect_ics(struct fb_info *info)
 {
-	struct sstfb_par *par = (struct sstfb_par *) info->par;
+	struct sstfb_par *par = info->par;
 	int m_clk0_1, m_clk0_7, m_clk1_b;
 	int n_clk0_1, n_clk0_7, n_clk1_b;
 	int i;
@@ -1023,7 +1024,7 @@ static int __devinit sst_detect_ics(stru
 static int sst_set_pll_att_ti(struct fb_info *info, 
 		const struct pll_timing *t, const int clock)
 {
-	struct sstfb_par *par = (struct sstfb_par *) info->par;
+	struct sstfb_par *par = info->par;
 	u8 cr0, cc;
 
 	/* enable indexed mode */
@@ -1077,7 +1078,7 @@ static int sst_set_pll_att_ti(struct fb_
 static int sst_set_pll_ics(struct fb_info *info,
 		const struct pll_timing *t, const int clock)
 {
-	struct sstfb_par *par = (struct sstfb_par *) info->par;
+	struct sstfb_par *par = info->par;
 	u8 pll_ctrl;
 
 	sst_dac_write(DACREG_ICS_PLLRMA, DACREG_ICS_PLL_CTRL);
@@ -1114,7 +1115,7 @@ static int sst_set_pll_ics(struct fb_inf
 
 static void sst_set_vidmod_att_ti(struct fb_info *info, const int bpp)
 {
-	struct sstfb_par *par = (struct sstfb_par *) info->par;
+	struct sstfb_par *par = info->par;
 	u8 cr0;
 
 	sst_dac_write(DACREG_WMA, 0); 	/* backdoor */
@@ -1149,7 +1150,7 @@ static void sst_set_vidmod_att_ti(struct
 
 static void sst_set_vidmod_ics(struct fb_info *info, const int bpp)
 {
-	struct sstfb_par *par = (struct sstfb_par *) info->par;
+	struct sstfb_par *par = info->par;
 
 	switch(bpp) {
 	case 16:
@@ -1308,7 +1309,7 @@ static int __devinit sst_init(struct fb_
 
 static void  __devexit sst_shutdown(struct fb_info *info)
 {
-	struct sstfb_par *par = (struct sstfb_par *) info->par;
+	struct sstfb_par *par = info->par;
 	struct pci_dev *dev = par->dev;
 	struct pll_timing gfx_timings;
 	int Fout;
@@ -1394,12 +1395,6 @@ static int __devinit sstfb_probe(struct 
 	struct sst_spec *spec;
 	int err;
 
-	struct all_info {
-		struct fb_info info;
-		struct sstfb_par par;
-		u32 pseudo_palette[16];
-	} *all;
-	
 	/* Enable device in PCI config. */
 	if ((err=pci_enable_device(pdev))) {
 		eprintk("cannot enable device\n");
@@ -1407,14 +1402,13 @@ static int __devinit sstfb_probe(struct 
 	}
 
 	/* Allocate the fb and par structures.  */
-	all = kmalloc(sizeof(*all), GFP_KERNEL);
-	if (!all)
+	info = framebuffer_alloc(sizeof(struct sstfb_par), &pdev->dev);
+	if (!info)
 		return -ENOMEM;
-	memset(all, 0, sizeof(*all));
-	pci_set_drvdata(pdev, all);
+
+	pci_set_drvdata(pdev, info);
 	
-	info = &all->info;
-	par  = info->par = &all->par;
+	par  = info->par;
 	fix  = &info->fix;
 	
 	par->type = id->driver_data;
@@ -1471,7 +1465,7 @@ static int __devinit sstfb_probe(struct 
 
 	info->flags	= FBINFO_DEFAULT;
 	info->fbops	= &sstfb_ops;
-	info->pseudo_palette = &all->pseudo_palette;
+	info->pseudo_palette = par->palette;
 
 	fix->type	= FB_TYPE_PACKED_PIXELS;
 	fix->visual	= FB_VISUAL_TRUECOLOR;
@@ -1527,7 +1521,7 @@ fail_mmio_remap:
 fail_fb_mem:
 	release_mem_region(fix->mmio_start, info->fix.mmio_len);
 fail_mmio_mem:
-	kfree(info);
+	framebuffer_release(info);
 	return -ENXIO; 	/* no voodoo detected */
 }
 
@@ -1537,7 +1531,7 @@ static void __devexit sstfb_remove(struc
 	struct fb_info *info;
 
 	info = pci_get_drvdata(pdev);
-	par = (struct sstfb_par *) info->par;
+	par = info->par;
 	
 	sst_shutdown(info);
 	unregister_framebuffer(info);
@@ -1545,7 +1539,7 @@ static void __devexit sstfb_remove(struc
 	iounmap(par->mmio_vbase);
 	release_mem_region(info->fix.smem_start, 0x400000);
 	release_mem_region(info->fix.mmio_start, info->fix.mmio_len);
-	kfree(info);
+	framebuffer_release(info);
 }
 
 
@@ -1613,7 +1607,7 @@ static int sstfb_dump_regs(struct fb_inf
 
 	const int pci_s = sizeof(pci_regs)/sizeof(pci_regs[0]);
 	const int sst_s = sizeof(sst_regs)/sizeof(sst_regs[0]);
-	struct sstfb_par *par = (struct sstfb_par *) info->par;
+	struct sstfb_par *par = info->par;
 	struct pci_dev *dev = par->dev;
 	u32 pci_res[pci_s];
 	u32 sst_res[sst_s];
diff --git a/include/video/sstfb.h b/include/video/sstfb.h
index 0d77b52..3570f9c 100644
--- a/include/video/sstfb.h
+++ b/include/video/sstfb.h
@@ -334,6 +334,7 @@ struct sst_spec {
 };
 
 struct sstfb_par {
+	u32 palette[16];
 	unsigned int yDim;
 	unsigned int hSyncOn;	/* hsync_len */
 	unsigned int hSyncOff;	/* left_margin + xres + right_margin */


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
