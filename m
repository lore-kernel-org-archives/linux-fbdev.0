From: Andres Salomon <dilinger@queued.net>
Subject: [PATCH 1/3] gxfb/lxfb: use VSA definitions when
 fetching framebuffer size
Date: Mon, 14 Apr 2008 03:52:13 -0400
Message-ID: <20080414035213.1223c84b@ephemeral>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JlJSA-0007NU-CQ for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 14 Apr 2008 00:50:14 -0700
Received: from mail.queued.net ([207.210.101.209])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JlJS9-0003Ca-0T
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 14 Apr 2008 00:50:14 -0700
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jordan.crouse@amd.com, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, linux-kernel@vger.kernel.org, info-linux@geode.amd.com


..Rather than using magic constants.

Signed-off-by: Andres Salomon <dilinger@debian.org>
---
 drivers/video/geode/display_gx.c |    7 ++++---
 drivers/video/geode/lxfb_ops.c   |    6 +++---
 include/asm-x86/geode.h          |    1 +
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/video/geode/display_gx.c b/drivers/video/geode/display_gx.c
index 3743c87..1e82ecc 100644
--- a/drivers/video/geode/display_gx.c
+++ b/drivers/video/geode/display_gx.c
@@ -17,6 +17,7 @@
 #include <asm/io.h>
 #include <asm/div64.h>
 #include <asm/delay.h>
+#include <asm/geode.h>
 
 #include "gxfb.h"
 
@@ -28,10 +29,10 @@ unsigned int gx_frame_buffer_size(void)
 	/* Virtual register class = 0x02 */
 	/* VG_MEM_SIZE(512Kb units) = 0x00 */
 
-	outw(0xFC53, 0xAC1C);
-	outw(0x0200, 0xAC1C);
+	outw(VSA_VR_UNLOCK, VSA_VRC_INDEX);
+	outw(VSA_VR_MEM_SIZE, VSA_VRC_INDEX);
 
-	val = (unsigned int)(inw(0xAC1E)) & 0xFFl;
+	val = (unsigned int)(inw(VSA_VRC_DATA)) & 0xFFl;
 	return (val << 19);
 }
 
diff --git a/drivers/video/geode/lxfb_ops.c b/drivers/video/geode/lxfb_ops.c
index c0413ea..51080db 100644
--- a/drivers/video/geode/lxfb_ops.c
+++ b/drivers/video/geode/lxfb_ops.c
@@ -283,10 +283,10 @@ unsigned int lx_framebuffer_size(void)
 	/* Virtual Register Class    = 0x02                     */
 	/* VG_MEM_SIZE (1MB units)   = 0x00                     */
 
-	outw(0xFC53, 0xAC1C);
-	outw(0x0200, 0xAC1C);
+	outw(VSA_VR_UNLOCK, VSA_VRC_INDEX);
+	outw(VSA_VR_MEM_SIZE, VSA_VRC_INDEX);
 
-	val = (unsigned int)(inw(0xAC1E)) & 0xFE;
+	val = (unsigned int)(inw(VSA_VRC_DATA)) & 0xFE;
 	return (val << 20);
 }
 
diff --git a/include/asm-x86/geode.h b/include/asm-x86/geode.h
index 6cded63..6c8a2a0 100644
--- a/include/asm-x86/geode.h
+++ b/include/asm-x86/geode.h
@@ -109,6 +109,7 @@ extern int geode_get_dev_base(unsigned int dev);
 #define VSA_VRC_DATA		0xAC1E
 #define VSA_VR_UNLOCK		0xFC53	/* unlock virtual register */
 #define VSA_VR_SIGNATURE	0x0003
+#define VSA_VR_MEM_SIZE		0x0200
 #define VSA_SIG			0x4132	/* signature is ascii 'VSA2' */
 
 /* GPIO */
-- 
1.5.4.4



-- 
Need a kernel or Debian developer?  Contact me, I'm looking for contracts.

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
