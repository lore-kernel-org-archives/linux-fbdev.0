From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: [PATCH 1/6] FB: Get the Geode GX frambuffer
	size from the BIOS
Date: Tue, 28 Nov 2006 16:14:51 -0700
Message-ID: <20061128231447.25769.6360.stgit@cosmic.amd.com>
References: <20061128230639.25769.43.stgit@cosmic.amd.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GpC4J-00046F-Ox for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 28 Nov 2006 15:08:51 -0800
Received: from outbound-fra.frontbridge.com ([62.209.45.174]
	helo=outbound3-fra-R.bigfish.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GpC4I-0001XF-0i
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 28 Nov 2006 15:08:51 -0800
In-Reply-To: <20061128230639.25769.43.stgit@cosmic.amd.com>
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
To: linux-fbdev-devel@lists.sourceforge.net, info-linux@ldcmail.amd.com
Cc: akpm@osdl.org

From: Jordan Crouse <jordan.crouse@amd.com>

Use the Geode GX BIOS virtual registers to get the actual size of the
framebuffer.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 drivers/video/geode/display_gx.c |   15 ++++++++++++---
 drivers/video/geode/display_gx.h |    2 +-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/video/geode/display_gx.c b/drivers/video/geode/display_gx.c
index 825c340..0245169 100644
--- a/drivers/video/geode/display_gx.c
+++ b/drivers/video/geode/display_gx.c
@@ -21,10 +21,19 @@ #include <asm/delay.h>
 #include "geodefb.h"
 #include "display_gx.h"
 
-int gx_frame_buffer_size(void)
+unsigned int gx_frame_buffer_size(void)
 {
-	/* Assuming 16 MiB. */
-	return 16*1024*1024;
+	unsigned int val;
+
+	/* FB size is reported by a virtual register */
+	/* Virtual register class = 0x02 */
+	/* VG_MEM_SIZE(512Kb units) = 0x00 */
+
+	outw(0xFC53, 0xAC1C);
+	outw(0x0200, 0xAC1C);
+
+	val = (unsigned int)(inw(0xAC1E)) & 0xFFl;
+	return (val << 19);
 }
 
 int gx_line_delta(int xres, int bpp)
diff --git a/drivers/video/geode/display_gx.h b/drivers/video/geode/display_gx.h
index 86c6233..41e79f4 100644
--- a/drivers/video/geode/display_gx.h
+++ b/drivers/video/geode/display_gx.h
@@ -11,7 +11,7 @@
 #ifndef __DISPLAY_GX_H__
 #define __DISPLAY_GX_H__
 
-int gx_frame_buffer_size(void);
+unsigned int gx_frame_buffer_size(void);
 int gx_line_delta(int xres, int bpp);
 
 extern struct geode_dc_ops gx_dc_ops;



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
