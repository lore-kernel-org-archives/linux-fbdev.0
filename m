From: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] fix mach64_gx.c
Date: Fri, 2 May 2003 16:22:12 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <16050.3732.615164.697680@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from dp.samba.org ([66.70.73.150] helo=lists.samba.org)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19BTwT-0004M8-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 01 May 2003 23:22:45 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

The patch below is needed for drivers/video/aty/mach64_gx.c to compile
correctly.  Somehow a couple of the var_to_pll routines got the wrong
argument list.

Paul.

diff -urN linux-2.5/drivers/video/aty/mach64_gx.c pmac-2.5/drivers/video/aty/mach64_gx.c
--- linux-2.5/drivers/video/aty/mach64_gx.c	2003-04-21 10:27:15.000000000 +1000
+++ pmac-2.5/drivers/video/aty/mach64_gx.c	2003-04-23 22:10:54.000000000 +1000
@@ -494,7 +494,7 @@
      */
 
 static int aty_var_to_pll_1703(const struct fb_info *info, u32 vclk_per,
-			       u32 vclk_per, u8 bpp, union aty_pll *pll)
+			       u8 bpp, union aty_pll *pll)
 {
 	u32 mhz100;		/* in 0.01 MHz */
 	u32 program_bits;
@@ -610,7 +610,7 @@
      */
 
 static int aty_var_to_pll_8398(const struct fb_info *info, u32 vclk_per,
-			       u32 vclk_per, u8 bpp, union aty_pll *pll)
+			       u8 bpp, union aty_pll *pll)
 {
 	u32 tempA, tempB, fOut, longMHz100, diff, preDiff;
 


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
