From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 24/24] sisfb: Fix pseudo_palette array
	size and overrun
Date: Sat, 02 Jun 2007 18:16:14 +0800
Message-ID: <4661436E.4030305@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HuQlH-0000ao-LY for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 03:23:08 -0700
Received: from py-out-1112.google.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HuQlH-0001zh-9f
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 03:23:07 -0700
Received: by py-out-1112.google.com with SMTP id u77so1509718pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 02 Jun 2007 03:23:06 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Winischhofer <thomas@winischhofer.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

- the pseudo_palette is only 16 elements long.
- do not write to the pseudo_palette if regno (array index) is more than 15.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/sis/sis.h      |    2 +-
 drivers/video/sis/sis_main.c |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/video/sis/sis.h b/drivers/video/sis/sis.h
index d5e2d9c..d53bf69 100644
--- a/drivers/video/sis/sis.h
+++ b/drivers/video/sis/sis.h
@@ -479,7 +479,7 @@ struct sis_video_info {
 	struct fb_var_screeninfo default_var;
 
 	struct fb_fix_screeninfo sisfb_fix;
-	u32		pseudo_palette[17];
+	u32		pseudo_palette[16];
 
 	struct sisfb_monitor {
 		u16 hmin;
diff --git a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
index a30e1e1..bb8088e 100644
--- a/drivers/video/sis/sis_main.c
+++ b/drivers/video/sis/sis_main.c
@@ -1405,12 +1405,18 @@ sisfb_setcolreg(unsigned regno, unsigned
 		}
 		break;
 	case 16:
+		if (regno >= 16)
+			break;
+
 		((u32 *)(info->pseudo_palette))[regno] =
 				(red & 0xf800)          |
 				((green & 0xfc00) >> 5) |
 				((blue & 0xf800) >> 11);
 		break;
 	case 32:
+		if (regno >= 16)
+			break;
+
 		red >>= 8;
 		green >>= 8;
 		blue >>= 8;


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
