From: Kimball Murray <kimball.murray@gmail.com>
Subject: Reworked [GIT PATCH 1/1] support 24bpp (32bpp
	minus alpha) in radeonfb driver
Date: Mon, 13 Nov 2006 14:23:56 -0500
Message-ID: <20061113192006.27852.45907.sendpatchset@dhcp83-86.boston.redhat.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GjhPa-0005ND-MZ for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Nov 2006 11:24:06 -0800
Received: from mx1.redhat.com ([66.187.233.31])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GjhPa-0007ze-9e
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Nov 2006 11:24:06 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: benh@kernel.crashing.org, Kimball Murray <kimball.murray@gmail.com>, charlotte.richardson@stratus.com

Here is a rework of patch sent before which fixed 24-bit mode on a
particular vernsion of the Radeon card, but broke it on others.

This rework simply adds an additional check on the card version so that
the code only affects our model.  Other models will behave as before.

This patch was generated against Linus' git tree.

Signed-off-by: Charlotte Richardson (charlotte.richardson@stratus.com

--------------------------- snip -----------------------
diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
index 0ed577e..d190631 100644
--- a/drivers/video/aty/radeon_base.c
+++ b/drivers/video/aty/radeon_base.c
@@ -719,11 +719,11 @@ static int radeonfb_check_var (struct fb
 			v.bits_per_pixel = 16;
 			break;
 		case 17 ... 24:
-#if 0 /* Doesn't seem to work */
-			v.bits_per_pixel = 24;
-			break;
-#endif			
-			return -EINVAL;
+			if (rinfo->chipset == PCI_CHIP_RN50) {
+				v.bits_per_pixel = 24;
+				break;
+			} else
+				return -EINVAL;
 		case 25 ... 32:
 			v.bits_per_pixel = 32;
 			break;
diff --git a/drivers/video/aty/radeonfb.h b/drivers/video/aty/radeonfb.h
index d5ff224..989f468 100644
--- a/drivers/video/aty/radeonfb.h
+++ b/drivers/video/aty/radeonfb.h
@@ -517,6 +517,8 @@ static inline int round_div(int num, int
 
 static inline int var_to_depth(const struct fb_var_screeninfo *var)
 {
+	if (var->bits_per_pixel == 32)
+	       return (var->transp.length == 8) ? 32 : 24;
 	if (var->bits_per_pixel != 16)
 		return var->bits_per_pixel;
 	return (var->green.length == 5) ? 15 : 16;
@@ -531,7 +533,9 @@ static inline u32 radeon_get_dstbpp(u16 
        		return DST_15BPP;
        	case 16:
        		return DST_16BPP;
-       	case 32:
+	case 24:
+       		return DST_24BPP;
+	case 32:
        		return DST_32BPP;
        	default:
        		return 0;

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
