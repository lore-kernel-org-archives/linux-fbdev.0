From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 4/9] vesafb: Fix return code of vesafb_setcolreg
Date: Thu, 04 May 2006 20:31:07 +0800
Message-ID: <4459F40B.2000700@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fbd5c-0007mW-Fq
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 May 2006 05:37:52 -0700
Received: from wx-out-0102.google.com ([66.249.82.202])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Fbd5c-0002Pa-Aa
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 May 2006 05:37:52 -0700
Received: by wx-out-0102.google.com with SMTP id h26so310349wxd
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 04 May 2006 05:37:52 -0700 (PDT)
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

If the hardware palette cannot be accessed, make vesafb_setcolreg return
a nonzero value.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/vesafb.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/video/vesafb.c b/drivers/video/vesafb.c
index 2fbaa84..eff2ebc 100644
--- a/drivers/video/vesafb.c
+++ b/drivers/video/vesafb.c
@@ -80,10 +80,11 @@ static int vesafb_pan_display(struct fb_
 	return 0;
 }
 
-static void vesa_setpalette(int regno, unsigned red, unsigned green,
+static int vesa_setpalette(int regno, unsigned red, unsigned green,
 			    unsigned blue)
 {
 	int shift = 16 - depth;
+	int err = -EINVAL;
 
 #ifdef __i386__
 	struct { u_char blue, green, red, pad; } entry;
@@ -102,7 +103,7 @@ static void vesa_setpalette(int regno, u
                   "d" (regno),          /* EDX */
                   "D" (&entry),         /* EDI */
                   "S" (&pmi_pal));      /* ESI */
-		return;
+		err = 0;
 	}
 #endif
 
@@ -110,18 +111,23 @@ static void vesa_setpalette(int regno, u
  * without protected mode interface and if VGA compatible,
  * try VGA registers...
  */
-	if (vga_compat) {
+	if (err && vga_compat) {
 		outb_p(regno,       dac_reg);
 		outb_p(red   >> shift, dac_val);
 		outb_p(green >> shift, dac_val);
 		outb_p(blue  >> shift, dac_val);
+		err = 0;
 	}
+
+	return err;
 }
 
 static int vesafb_setcolreg(unsigned regno, unsigned red, unsigned green,
 			    unsigned blue, unsigned transp,
 			    struct fb_info *info)
 {
+	int err = 0;
+
 	/*
 	 *  Set a single color register. The values supplied are
 	 *  already rounded down to the hardware's capabilities
@@ -133,7 +139,7 @@ static int vesafb_setcolreg(unsigned reg
 		return 1;
 
 	if (info->var.bits_per_pixel == 8)
-		vesa_setpalette(regno,red,green,blue);
+		err = vesa_setpalette(regno,red,green,blue);
 	else if (regno < 16) {
 		switch (info->var.bits_per_pixel) {
 		case 16:
@@ -164,7 +170,7 @@ static int vesafb_setcolreg(unsigned reg
 		}
 	}
 
-	return 0;
+	return err;
 }
 
 static struct fb_ops vesafb_ops = {



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
