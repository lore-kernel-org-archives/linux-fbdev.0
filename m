From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 3/8] fbdev: Use soft_cursor in i810fb
Date: Sun, 7 Nov 2004 22:42:35 +0800
Message-ID: <20041107213322.18C3811C60AD@smtp-3.hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQufM-0003yE-RU
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Nov 2004 13:33:40 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CQufL-0008HE-Md
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Nov 2004 13:33:40 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 948769BEFF8
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  7 Nov 2004 21:33:26 +0000 (UTC)
Content-Disposition: inline
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

The hardware cursor implementation in i810fb broke sometime during
2.6.  Until this is fixed, temporarily use soft_cursor().

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 i810.h      |    1 +
 i810_main.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff -Nru a/drivers/video/i810/i810.h b/drivers/video/i810/i810.h
--- a/drivers/video/i810/i810.h	2004-10-23 02:52:37 +08:00
+++ b/drivers/video/i810/i810.h	2004-11-07 21:31:13 +08:00
@@ -201,6 +201,7 @@
 #define HAS_ACCELERATION            2
 #define ALWAYS_SYNC                 4
 #define LOCKUP                      8
+#define USE_HWCUR                  16
 
 struct gtt_data {
 	struct agp_memory *i810_fb_memory;
diff -Nru a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
--- a/drivers/video/i810/i810_main.c	2004-10-30 19:10:42 +08:00
+++ b/drivers/video/i810/i810_main.c	2004-11-07 21:31:13 +08:00
@@ -1403,7 +1403,8 @@
 	struct i810fb_par *par = (struct i810fb_par *)info->par;
 	u8 __iomem *mmio = par->mmio_start_virtual;
 
-	if (!info->var.accel_flags || par->dev_flags & LOCKUP) 
+	if (!(par->dev_flags & USE_HWCUR) || !info->var.accel_flags ||
+	    par->dev_flags & LOCKUP)
 		return soft_cursor(info, cursor);
 
 	if (cursor->image.width > 64 || cursor->image.height > 64)




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
