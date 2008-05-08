From: David Miller <davem@davemloft.net>
Subject: [PATCH]: radeon: Misc corrections.
Date: Thu, 08 May 2008 03:22:38 -0700 (PDT)
Message-ID: <20080508.032238.23875845.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ju3Gw-0001JX-G1 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 May 2008 03:22:46 -0700
Received: from [74.93.104.97] (helo=sunset.davemloft.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ju3Gv-0005om-WC
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 May 2008 03:22:46 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: benh@kernel.crashing.org
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


I have a new PCI-E radeon RV380 series card (PCI device ID 5b64) that
hangs in my sparc64 boxes when the init scripts set the font.  The
problem goes away if I disable acceleration.

I haven't figured out that bug yet, but along the way
I found some corrections to make based upon some auditing.

1) The RB2D_DC_FLUSH_ALL value used by the kernel fb driver
   and the XORG video driver differ.  I've made the kernel
   match what XORG is using.

2) In radeonfb_engine_reset() we have top-level code structure
   that roughly looks like:

	if (family is 300, 350, or V350)
		do this;
	else
		do that;
	...
	if (family is NOT 300, OR
	    family is NOT 350, OR
	    family is NOT V350)
		do another thing;

   this last conditional makes no sense, is always true,
   and obviously was likely meant to be "family is NOT
   300, 350, or V350".  So I've made the code match the
   intent.

Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/video/aty/radeon_accel.c b/drivers/video/aty/radeon_accel.c
index 3ca27cb..4d13f68 100644
--- a/drivers/video/aty/radeon_accel.c
+++ b/drivers/video/aty/radeon_accel.c
@@ -241,8 +241,8 @@ void radeonfb_engine_reset(struct radeonfb_info *rinfo)
 	INREG(HOST_PATH_CNTL);
 	OUTREG(HOST_PATH_CNTL, host_path_cntl);
 
-	if (rinfo->family != CHIP_FAMILY_R300 ||
-	    rinfo->family != CHIP_FAMILY_R350 ||
+	if (rinfo->family != CHIP_FAMILY_R300 &&
+	    rinfo->family != CHIP_FAMILY_R350 &&
 	    rinfo->family != CHIP_FAMILY_RV350)
 		OUTREG(RBBM_SOFT_RESET, rbbm_soft_reset);
 
diff --git a/include/video/radeon.h b/include/video/radeon.h
index 83467e1..95a1f20 100644
--- a/include/video/radeon.h
+++ b/include/video/radeon.h
@@ -527,8 +527,9 @@
 
 
 /* DSTCACHE_CTLSTAT bit constants */
-#define RB2D_DC_FLUSH				   (3 << 0)
-#define RB2D_DC_FLUSH_ALL			   0xf
+#define RB2D_DC_FLUSH_2D			   (1 << 0)
+#define RB2D_DC_FREE_2D				   (1 << 2)
+#define RB2D_DC_FLUSH_ALL			   (RB2D_DC_FLUSH_2D | RB2D_DC_FREE_2D)
 #define RB2D_DC_BUSY				   (1 << 31)
 
 

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
