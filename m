From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 6/13] rivafb: use constants instead of
	magic values
Date: Tue, 01 Aug 2006 07:33:32 +0800
Message-ID: <44CE934C.9020704@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G7hOT-00038u-0e for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 16:41:53 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G7hOS-0004Mn-OX
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 16:41:53 -0700
Received: by py-out-1112.google.com with SMTP id d42so802545pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 31 Jul 2006 16:41:52 -0700 (PDT)
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
Cc: Guido Guenther <agx@sigxcpu.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Guido Guenther <agx@sigxcpu.org>

use (MIN/MAX)_LEVEL and FB_(UN)BLANK instead of the values they are defined to

Signed-off-by: Guido Guenther <agx@sigxcpu.org>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/riva/fbdev.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
index 76fc9d3..43aa8be 100644
--- a/drivers/video/riva/fbdev.c
+++ b/drivers/video/riva/fbdev.c
@@ -389,8 +389,8 @@ #endif
 	mutex_lock(&info->bl_mutex);
 	info->bl_dev = bd;
 	fb_bl_default_curve(info, 0,
-		0x158 * FB_BACKLIGHT_MAX / MAX_LEVEL,
-		0x534 * FB_BACKLIGHT_MAX / MAX_LEVEL);
+		MIN_LEVEL * FB_BACKLIGHT_MAX / MAX_LEVEL,
+		FB_BACKLIGHT_MAX);
 	mutex_unlock(&info->bl_mutex);
 
 	up(&bd->sem);
@@ -780,7 +780,7 @@ static void riva_load_video_mode(struct 
 	
 	NVTRACE_ENTER();
 	/* time to calculate */
-	rivafb_blank(1, info);
+	rivafb_blank(FB_BLANK_NORMAL, info);
 
 	bpp = info->var.bits_per_pixel;
 	if (bpp == 16 && info->var.green.length == 5)
@@ -913,7 +913,7 @@ static void riva_load_video_mode(struct 
 	par->current_state = newmode;
 	riva_load_state(par, &par->current_state);
 	par->riva.LockUnlock(&par->riva, 0); /* important for HW cursor */
-	rivafb_blank(0, info);
+	rivafb_blank(FB_BLANK_UNBLANK, info);
 	NVTRACE_LEAVE();
 }
 



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
