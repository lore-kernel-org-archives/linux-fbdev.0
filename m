From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 11/16] pm2fb: Driver cleanups
Date: Mon, 28 Nov 2005 23:31:36 +0800
Message-ID: <438B22D8.5010707@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhGpA-0002Ry-3U
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 17:31:56 -0800
Received: from zproxy.gmail.com ([64.233.162.203])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EhGp9-00035W-SN
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 17:31:56 -0800
Received: by zproxy.gmail.com with SMTP id z3so2537654nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 29 Nov 2005 17:31:55 -0800 (PST)
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

- remove unneeded casts
- move memory for pseudo_palette inside struct pm2fb_par

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/pm2fb.c |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
index 0277ce0..5fe1979 100644
--- a/drivers/video/pm2fb.c
+++ b/drivers/video/pm2fb.c
@@ -91,6 +91,7 @@ struct pm2fb_par
 	u32		mem_config;	/* MemConfig reg at probe */
 	u32		mem_control;	/* MemControl reg at probe */
 	u32		boot_address;	/* BootAddress reg at probe */
+	u32             palette[16];
 };
 
 /*
@@ -674,7 +675,7 @@ static int pm2fb_check_var(struct fb_var
  */
 static int pm2fb_set_par(struct fb_info *info)
 {
-	struct pm2fb_par *par = (struct pm2fb_par *) info->par;
+	struct pm2fb_par *par = info->par;
 	u32 pixclock;
 	u32 width, height, depth;
 	u32 hsstart, hsend, hbend, htotal;
@@ -854,7 +855,7 @@ static int pm2fb_setcolreg(unsigned regn
 			   unsigned blue, unsigned transp,
 			   struct fb_info *info)
 {
-	struct pm2fb_par *par = (struct pm2fb_par *) info->par;
+	struct pm2fb_par *par = info->par;
 
 	if (regno >= info->cmap.len)  /* no. of hw registers */
 		return 1;
@@ -929,7 +930,7 @@ static int pm2fb_setcolreg(unsigned regn
    		case 16:
 		case 24:
 		case 32:	
-           		((u32*)(info->pseudo_palette))[regno] = v;
+           		par->palette[regno] = v;
 			break;
 		}
 		return 0;
@@ -955,7 +956,7 @@ static int pm2fb_setcolreg(unsigned regn
 static int pm2fb_pan_display(struct fb_var_screeninfo *var,
 			     struct fb_info *info)
 {
-	struct pm2fb_par *p = (struct pm2fb_par *) info->par;
+	struct pm2fb_par *p = info->par;
 	u32 base;
 	u32 depth;
 	u32 xres;
@@ -987,7 +988,7 @@ static int pm2fb_pan_display(struct fb_v
  */
 static int pm2fb_blank(int blank_mode, struct fb_info *info)
 {
-	struct pm2fb_par *par = (struct pm2fb_par *) info->par;
+	struct pm2fb_par *par = info->par;
 	u32 video = par->video;
 
 	DPRINTK("blank_mode %d\n", blank_mode);
@@ -1054,8 +1055,7 @@ static int __devinit pm2fb_probe(struct 
 {
 	struct pm2fb_par *default_par;
 	struct fb_info *info;
-	int size, err;
-	int err_retval = -ENXIO;
+	int err, err_retval = -ENXIO;
 
 	err = pci_enable_device(pdev);
 	if ( err ) {
@@ -1063,11 +1063,10 @@ static int __devinit pm2fb_probe(struct 
 		return err;
 	}
 
-	size = sizeof(struct pm2fb_par) + 256 * sizeof(u32);
-	info = framebuffer_alloc(size, &pdev->dev);
+	info = framebuffer_alloc(sizeof(struct pm2fb_par), &pdev->dev);
 	if ( !info )
 		return -ENOMEM;
-	default_par = (struct pm2fb_par *) info->par;
+	default_par = info->par;
 
 	switch (pdev->device) {
 	case  PCI_DEVICE_ID_TI_TVP4020:
@@ -1171,7 +1170,7 @@ static int __devinit pm2fb_probe(struct 
 
 	info->fbops		= &pm2fb_ops;
 	info->fix		= pm2fb_fix; 	
-	info->pseudo_palette	= (void *)(default_par + 1); 
+	info->pseudo_palette	= default_par->palette;
 	info->flags		= FBINFO_DEFAULT |
                                   FBINFO_HWACCEL_YPAN;
 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
