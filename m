From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] matroxfb: Remove fbcon.h from the main header file
Date: Sun, 20 Nov 2005 20:46:34 +0800
Message-ID: <4380702A.6090803@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EdxKd-00087C-Qr
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Nov 2005 14:06:43 -0800
Received: from zproxy.gmail.com ([64.233.162.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EdxKd-0004zc-JP
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Nov 2005 14:06:43 -0800
Received: by zproxy.gmail.com with SMTP id z3so556224nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 20 Nov 2005 14:06:43 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Petr Vandrovec <vandrove@vc.cvut.cz>

matroxfb has no need for struct display and fbcon.h. Remove.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/matrox/matroxfb_base.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/video/matrox/matroxfb_base.h b/drivers/video/matrox/matroxfb_base.h
index a8c47ad..3a3e180 100644
--- a/drivers/video/matrox/matroxfb_base.h
+++ b/drivers/video/matrox/matroxfb_base.h
@@ -50,8 +50,6 @@
 #include <asm/mtrr.h>
 #endif
 
-#include "../console/fbcon.h"
-
 #if defined(CONFIG_PPC_PMAC)
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
@@ -351,8 +349,6 @@ struct matrox_bios {
 		      } output;
 };
 
-extern struct display fb_display[];
-
 struct matrox_switch;
 struct matroxfb_driver;
 struct matroxfb_dh_fb_info;



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
