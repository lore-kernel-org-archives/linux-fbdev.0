From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Fri, 07 Aug 2015 12:16:04 +0000
Subject: [PATCH 3/5] staging: sm750fb: fix multiline comment
Message-Id: <1438949046-18765-3-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438949046-18765-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1438949046-18765-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Multiline comments are edited to be in the kernel coding style.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm750fb/sm750.c | 63 +++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index c16b293..fa2183d 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -182,8 +182,10 @@ static void lynxfb_ops_fillrect(struct fb_info *info,
 	par = info->par;
 	share = par->share;
 
-	/* each time 2d function begin to work,below three variable always need
-	 * be set, seems we can put them together in some place  */
+	/*
+	 * each time 2d function begin to work,below three variable always need
+	 * be set, seems we can put them together in some place
+	 */
 	base = par->crtc.oScreen;
 	pitch = info->fix.line_length;
 	Bpp = info->var.bits_per_pixel >> 3;
@@ -218,8 +220,10 @@ static void lynxfb_ops_copyarea(struct fb_info *info,
 	par = info->par;
 	share = par->share;
 
-	/* each time 2d function begin to work,below three variable always need
-	 * be set, seems we can put them together in some place  */
+	/*
+	 * each time 2d function begin to work,below three variable always need
+	 * be set, seems we can put them together in some place
+	 */
 	base = par->crtc.oScreen;
 	pitch = info->fix.line_length;
 	Bpp = info->var.bits_per_pixel >> 3;
@@ -249,8 +253,10 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
 
 	par = info->par;
 	share = par->share;
-	/* each time 2d function begin to work,below three variable always need
-	 * be set, seems we can put them together in some place  */
+	/*
+	 * each time 2d function begin to work,below three variable always need
+	 * be set, seems we can put them together in some place
+	 */
 	base = par->crtc.oScreen;
 	pitch = info->fix.line_length;
 	Bpp = info->var.bits_per_pixel >> 3;
@@ -334,9 +340,10 @@ static int lynxfb_ops_set_par(struct fb_info *info)
 	fix->line_length = line_length;
 	pr_info("fix->line_length = %d\n", fix->line_length);
 
-	/* var->red,green,blue,transp are need to be set by driver
+	/*
+	 * var->red,green,blue,transp are need to be set by driver
 	 * and these data should be set before setcolreg routine
-	 * */
+	 */
 
 	switch (var->bits_per_pixel) {
 	case 8:
@@ -811,8 +818,10 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	sm750fb_set_drv(par);
 	lynxfb_ops.fb_pan_display = lynxfb_ops_pan_display;
 
-	/* set current cursor variable and proc pointer,
-	 * must be set after crtc member initialized */
+	/*
+	 * set current cursor variable and proc pointer,
+	 * must be set after crtc member initialized
+	 */
 	crtc->cursor.offset = crtc->oScreen + crtc->vidmem_size - 1024;
 	crtc->cursor.mmio = share->pvReg + 0x800f0 + (int)crtc->channel * 0x140;
 
@@ -920,12 +929,13 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 
 	fix->smem_start = crtc->oScreen + share->vidmem_start;
 	pr_info("fix->smem_start = %lx\n", fix->smem_start);
-	/* according to mmap experiment from user space application,
+	/*
+	 * according to mmap experiment from user space application,
 	 * fix->mmio_len should not larger than virtual size
 	 * (xres_virtual x yres_virtual x ByPP)
 	 * Below line maybe buggy when user mmap fb dev node and write
 	 * data into the bound over virtual size
-	 * */
+	 */
 	fix->smem_len = crtc->vidmem_size;
 	pr_info("fix->smem_len = %x\n", fix->smem_len);
 	info->screen_size = fix->smem_len;
@@ -1083,8 +1093,10 @@ static int lynxfb_pci_probe(struct pci_dev *pdev,
 		goto err_enable;
 	}
 
-	/* though offset of share in sm750_share is 0,
-	 * we use this marcro as the same */
+	/*
+	 * though offset of share in sm750_share is 0,
+	 * we use this marcro as the same
+	 */
 	spec_offset = offsetof(struct sm750_share, share);
 
 	spec_share = kzalloc(sizeof(*spec_share), GFP_KERNEL);
@@ -1108,10 +1120,12 @@ static int lynxfb_pci_probe(struct pci_dev *pdev,
 	spin_lock_init(&share->slock);
 
 	if (!share->accel_off) {
-		/* hook deInit and 2d routines, notes that below hw_xxx
+		/*
+		 * hook deInit and 2d routines, notes that below hw_xxx
 		 * routine can work on most of lynx chips
 		 * if some chip need specific function,
-		 * please hook it in smXXX_set_drv routine */
+		 * please hook it in smXXX_set_drv routine
+		 */
 		share->accel.de_init = hw_de_init;
 		share->accel.de_fillrect = hw_fillrect;
 		share->accel.de_copyarea = hw_copyarea;
@@ -1262,14 +1276,15 @@ static int __init lynxfb_setup(char *options)
 
 	tmp = g_settings;
 
-	/*	Notes:
-		char * strsep(char **s,const char * ct);
-		@s: the string to be searched
-		@ct :the characters to search for
-
-		strsep() updates @options to pointer after the first found token
-		it also returns the pointer ahead the token.
-		*/
+	/*
+	 * Notes:
+	 * char * strsep(char **s,const char * ct);
+	 * @s: the string to be searched
+	 * @ct :the characters to search for
+	 *
+	 * strsep() updates @options to pointer after the first found token
+	 * it also returns the pointer ahead the token.
+	 */
 	while ((opt = strsep(&options, ":")) != NULL) {
 		/* options that mean for any lynx chips are configured here */
 		if (!strncmp(opt, "noaccel", strlen("noaccel")))
-- 
1.9.1

