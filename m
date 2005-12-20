From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 5/9] s3c2410fb: cleanup and fix
Date: Tue, 20 Dec 2005 20:50:20 +0800
Message-ID: <43A7FE0C.1090105@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EoyF5-0002Bx-Gg
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Dec 2005 23:18:31 -0800
Received: from zproxy.gmail.com ([64.233.162.201])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EoyF4-0005tJ-49
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Dec 2005 23:18:31 -0800
Received: by zproxy.gmail.com with SMTP id r28so82174nza
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 20 Dec 2005 23:18:29 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Arnaud Patard <arnaud.patard@rtp-net.org>

From: Arnaud Patard <arnaud.patard@rtp-net.org>
    
Here are some cleanups for the s3c2410fb drivers. It :
* Removes a buggy call to s3c2410fb_init_registers. There was two calls
  to this function but the first was done without all initialisations
  done. No oops but it may confuse some LCDs.
* Makes two functions static.
    
Signed-Off-By: Arnaud Patard <arnaud.patard@rtp-net.org>
Signed-Off-By: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/s3c2410fb.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
index ce6e749..1ff78cb 100644
--- a/drivers/video/s3c2410fb.c
+++ b/drivers/video/s3c2410fb.c
@@ -552,7 +552,7 @@ static inline void modify_gpio(void __io
  * s3c2410fb_init_registers - Initialise all LCD-related registers
  */
 
-int s3c2410fb_init_registers(struct s3c2410fb_info *fbi)
+static int s3c2410fb_init_registers(struct s3c2410fb_info *fbi)
 {
 	unsigned long flags;
 
@@ -634,7 +634,7 @@ static irqreturn_t s3c2410fb_irq(int irq
 
 static char driver_name[]="s3c2410fb";
 
-int __init s3c2410fb_probe(struct platform_device *pdev)
+static int __init s3c2410fb_probe(struct platform_device *pdev)
 {
 	struct s3c2410fb_info *info;
 	struct fb_info	   *fbinfo;
@@ -667,8 +667,6 @@ int __init s3c2410fb_probe(struct platfo
 	info->fb = fbinfo;
 	platform_set_drvdata(pdev, fbinfo);
 
-	s3c2410fb_init_registers(info);
-
 	dprintk("devinit\n");
 
 	strcpy(fbinfo->fix.id, driver_name);
@@ -701,8 +699,8 @@ int __init s3c2410fb_probe(struct platfo
 	fbinfo->var.yres_virtual    = mach_info->yres.defval;
 	fbinfo->var.bits_per_pixel  = mach_info->bpp.defval;
 
-	fbinfo->var.upper_margin    = S3C2410_LCDCON2_GET_VBPD(mregs->lcdcon2) +1;
-	fbinfo->var.lower_margin    = S3C2410_LCDCON2_GET_VFPD(mregs->lcdcon2) +1;
+	fbinfo->var.upper_margin    = S3C2410_LCDCON2_GET_VBPD(mregs->lcdcon2) + 1;
+	fbinfo->var.lower_margin    = S3C2410_LCDCON2_GET_VFPD(mregs->lcdcon2) + 1;
 	fbinfo->var.vsync_len	    = S3C2410_LCDCON2_GET_VSPW(mregs->lcdcon2) + 1;
 
 	fbinfo->var.left_margin	    = S3C2410_LCDCON3_GET_HFPD(mregs->lcdcon3) + 1;




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
