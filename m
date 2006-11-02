From: akpm@osdl.org
Subject: [patch 02/25] radeonfb: support 24bpp (32bpp
	minus alpha)
Date: Wed, 01 Nov 2006 21:50:18 -0800
Message-ID: <200611020550.kA25oI4U002285@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GfVT3-0007Xc-Vg for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:50:22 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GfVT3-0008Ok-LW
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:50:21 -0800
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
Cc: akpm@osdl.org, kimball.murray@gmail.com, charlotte.richardson@stratus.com

From: Kimball Murray <kimball.murray@gmail.com>

Allow unpacked, 24bpp mode to work in the radeonfb driver.

I am submitting this on behalf of Charlotte Richardson at Stratus
Technologies, to support one of the Stratus hardware platforms.

Signed-off-by: Charlotte Richardson <charlotte.richardson@stratus.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/video/aty/radeon_base.c |    3 ---
 drivers/video/aty/radeonfb.h    |    6 +++++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff -puN drivers/video/aty/radeon_base.c~radeonfb-support-24bpp-32bpp-minus-alpha drivers/video/aty/radeon_base.c
--- a/drivers/video/aty/radeon_base.c~radeonfb-support-24bpp-32bpp-minus-alpha
+++ a/drivers/video/aty/radeon_base.c
@@ -719,11 +719,8 @@ static int radeonfb_check_var (struct fb
 			v.bits_per_pixel = 16;
 			break;
 		case 17 ... 24:
-#if 0 /* Doesn't seem to work */
 			v.bits_per_pixel = 24;
 			break;
-#endif			
-			return -EINVAL;
 		case 25 ... 32:
 			v.bits_per_pixel = 32;
 			break;
diff -puN drivers/video/aty/radeonfb.h~radeonfb-support-24bpp-32bpp-minus-alpha drivers/video/aty/radeonfb.h
--- a/drivers/video/aty/radeonfb.h~radeonfb-support-24bpp-32bpp-minus-alpha
+++ a/drivers/video/aty/radeonfb.h
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
_

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
