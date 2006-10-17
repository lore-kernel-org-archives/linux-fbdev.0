From: Kimball Murray <kimball.murray@gmail.com>
Subject: Resend2 [GIT PATCH 1/1] support 24bpp (32bpp
	minus alpha) in radeonfb driver
Date: Tue, 17 Oct 2006 10:55:26 -0400
Message-ID: <20061017145258.17779.56528.sendpatchset@dhcp83-86.boston.redhat.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GZqLx-0002XN-IK for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 17 Oct 2006 07:55:37 -0700
Received: from mx1.redhat.com ([66.187.233.31])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GZqLs-0003lk-J0
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 17 Oct 2006 07:55:37 -0700
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
Cc: benh@kernel.crashing.org, Kimball Murray <kimball.murray@gmail.com>

Trying yet again with a new list address.  Sorry Ben, you'll see this 3 times
now :)

This simple patch allows unpacked, 24bpp mode to work in the radeonfb driver.

The patch is against the mainline (Linus) git tree.  I am submitting this on
behalf of Charlotte Richardson at Stratus Technologies, to support one of the
Stratus hardware platforms.

Signed-off-by: Charlotte Richardson (charlotte.richardson@stratus.com)

--------------------------- snip -----------------------
diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
index 0ed577e..aef12f5 100644
--- a/drivers/video/aty/radeon_base.c
+++ b/drivers/video/aty/radeon_base.c
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
