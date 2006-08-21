From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 3/5] mbxfb: Fix framebuffer size smaller
	than requested
Date: Mon, 21 Aug 2006 18:54:05 +0800
Message-ID: <1156157645.6254.27.camel@daplas.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GF7Q6-0001Hi-9z for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Aug 2006 03:54:14 -0700
Received: from nz-out-0102.google.com ([64.233.162.193])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GF7Q4-0005UP-Vm
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Aug 2006 03:54:14 -0700
Received: by nz-out-0102.google.com with SMTP id l8so688649nzf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 21 Aug 2006 03:54:12 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Raphael Assenat <raph@8d.com>

From: Raphael Assenat <raph@8d.com>

This patch fixes a bug where we obtain a smaller resolution than requested.
(eg: in 640x480, only 639x479 usable pixels).

This was due to 1 being substracted from the xres and yres vars
two times: first in mbxfb.c and then in the macros from reg_bits.h.

This patch removes the minus ones from the mbxfb.c file. Tested and works.

Signed-off-by: Raphael Assenat <raph@8d.com>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/mbx/mbxfb.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/mbx/mbxfb.c b/drivers/video/mbx/mbxfb.c
index cfc6bf3..a32d1af 100644
--- a/drivers/video/mbx/mbxfb.c
+++ b/drivers/video/mbx/mbxfb.c
@@ -255,8 +255,8 @@ static int mbxfb_set_par(struct fb_info 
 
 	/* setup resolution */
 	gsctrl &= ~(FMsk(GSCTRL_GSWIDTH) | FMsk(GSCTRL_GSHEIGHT));
-	gsctrl |= Gsctrl_Width(info->var.xres - 1) |
-		Gsctrl_Height(info->var.yres - 1);
+	gsctrl |= Gsctrl_Width(info->var.xres) |
+		Gsctrl_Height(info->var.yres);
 	writel(gsctrl, GSCTRL);
 	udelay(1000);
 
@@ -413,8 +413,8 @@ static void __devinit setup_graphics(str
 {
 	unsigned long gsctrl;
 
-	gsctrl = GSCTRL_GAMMA_EN | Gsctrl_Width(fbi->var.xres - 1) |
-		Gsctrl_Height(fbi->var.yres - 1);
+	gsctrl = GSCTRL_GAMMA_EN | Gsctrl_Width(fbi->var.xres) |
+		Gsctrl_Height(fbi->var.yres);
 	switch (fbi->var.bits_per_pixel) {
 	case 16:
 		if (fbi->var.green.length == 5)



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
