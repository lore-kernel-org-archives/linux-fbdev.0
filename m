From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 5/9] vesafb: Prefer VGA registers over PMI
Date: Thu, 04 May 2006 20:32:20 +0800
Message-ID: <4459F454.2080304@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fbd5f-0007mb-PP
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 May 2006 05:37:55 -0700
Received: from wx-out-0102.google.com ([66.249.82.202])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Fbd5f-0002Pa-KY
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 May 2006 05:37:55 -0700
Received: by wx-out-0102.google.com with SMTP id h26so310349wxd
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 04 May 2006 05:37:55 -0700 (PDT)
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

- As per VESA specs, use the VGA registers to set the palette if the mode
is VGA compatible.  Otherwise, use the protected mode interface.
- Make pmi_setpal default to 1

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/vesafb.c |   32 +++++++++++++++++---------------
 1 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/video/vesafb.c b/drivers/video/vesafb.c
index eff2ebc..5718924 100644
--- a/drivers/video/vesafb.c
+++ b/drivers/video/vesafb.c
@@ -51,7 +51,7 @@ static int             inverse   = 0;
 static int             mtrr      = 0; /* disable mtrr */
 static int	       vram_remap __initdata = 0; /* Set amount of memory to be used */
 static int	       vram_total __initdata = 0; /* Set total amount of memory */
-static int             pmi_setpal = 0;	/* pmi for palette changes ??? */
+static int             pmi_setpal = 1;	/* pmi for palette changes ??? */
 static int             ypan       = 0;  /* 0..nothing, 1..ypan, 2..ywrap */
 static unsigned short  *pmi_base  = NULL;
 static void            (*pmi_start)(void);
@@ -86,10 +86,24 @@ static int vesa_setpalette(int regno, un
 	int shift = 16 - depth;
 	int err = -EINVAL;
 
+/*
+ * Try VGA registers first...
+ */
+	if (vga_compat) {
+		outb_p(regno,       dac_reg);
+		outb_p(red   >> shift, dac_val);
+		outb_p(green >> shift, dac_val);
+		outb_p(blue  >> shift, dac_val);
+		err = 0;
+	}
+
 #ifdef __i386__
-	struct { u_char blue, green, red, pad; } entry;
+/*
+ * Fallback to the PMI....
+ */
+	if (err && pmi_setpal) {
+		struct { u_char blue, green, red, pad; } entry;
 
-	if (pmi_setpal) {
 		entry.red   = red   >> shift;
 		entry.green = green >> shift;
 		entry.blue  = blue  >> shift;
@@ -107,18 +121,6 @@ static int vesa_setpalette(int regno, un
 	}
 #endif
 
-/*
- * without protected mode interface and if VGA compatible,
- * try VGA registers...
- */
-	if (err && vga_compat) {
-		outb_p(regno,       dac_reg);
-		outb_p(red   >> shift, dac_val);
-		outb_p(green >> shift, dac_val);
-		outb_p(blue  >> shift, dac_val);
-		err = 0;
-	}
-
 	return err;
 }
 



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
