From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 7/8] fbdev: atyfb_base.c requires atyfb_cursor()
Date: Tue, 2 Nov 2004 19:46:26 +0800
Message-ID: <200411021946.26862.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1COx8B-0002pf-HX
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 03:47:19 -0800
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1COx8A-0006If-9z
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 03:47:19 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 02BAC7058D
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue,  2 Nov 2004 11:47:01 +0000 (UTC)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Olaf Hering <olh@suse.de>

atyfb_base.c requires atyfb_cursor, but it is only available for linking
if CONFIG_FB_ATY_CT=y.
This patch moves the .o file to the CONFIG_FB_ATY rule.

Signed-off-by: Olaf Hering <olh@suse.de>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -Nru a/drivers/video/aty/Makefile b/drivers/video/aty/Makefile
--- a/drivers/video/aty/Makefile	2004-10-19 20:22:37 +08:00
+++ b/drivers/video/aty/Makefile	2004-11-01 22:42:04 +08:00
@@ -2,9 +2,9 @@
 obj-$(CONFIG_FB_ATY128) += aty128fb.o
 obj-$(CONFIG_FB_RADEON) += radeonfb.o
 
-atyfb-y				:= atyfb_base.o mach64_accel.o
+atyfb-y				:= atyfb_base.o mach64_accel.o mach64_cursor.o
 atyfb-$(CONFIG_FB_ATY_GX)	+= mach64_gx.o
-atyfb-$(CONFIG_FB_ATY_CT)	+= mach64_ct.o mach64_cursor.o
+atyfb-$(CONFIG_FB_ATY_CT)	+= mach64_ct.o
 atyfb-objs			:= $(atyfb-y)
 
 radeonfb-y			:= radeon_base.o radeon_pm.o radeon_monitor.o radeon_accel.o




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
