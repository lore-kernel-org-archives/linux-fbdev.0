From: "Jon Dufresne" <jon.dufresne@gmail.com>
Subject: [PATCH] fix EDID parser to detect interlace
	modes
Date: Mon, 22 Sep 2008 13:45:54 -0700
Message-ID: <376ea3380809221345o6718da05rb645340e9e9408cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jon.dufresne@gmail.com>) id 1KhsIF-0001QX-2M
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 22 Sep 2008 20:46:03 +0000
Received: from ey-out-1920.google.com ([74.125.78.145])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KhsI9-0007N2-9t for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 22 Sep 2008 20:46:03 +0000
Received: by ey-out-1920.google.com with SMTP id 4so451462eyk.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 22 Sep 2008 13:45:54 -0700 (PDT)
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

The current EDID parser in the linux kernel ignores interlace modes.
The patch below looks for the edid interlace flag and adjusts the
vertical resolution if it is found.

Signed-off-by: Jon Dufresne <jon.dufresne@gmail.com>
---
diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index 6a0aa18..5c1a2c0 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -564,7 +564,13 @@ static void get_detailed_timing(unsigned char *block,
 		mode->sync |= FB_SYNC_VERT_HIGH_ACT;
 	mode->refresh = PIXEL_CLOCK/((H_ACTIVE + H_BLANKING) *
 				     (V_ACTIVE + V_BLANKING));
-	mode->vmode = 0;
+	if (INTERLACED) {
+		mode->yres *= 2;
+		mode->upper_margin *= 2;
+		mode->lower_margin *= 2;
+		mode->vsync_len *= 2;
+		mode->vmode |= FB_VMODE_INTERLACED;
+	}
 	mode->flag = FB_MODE_IS_DETAILED;

 	DPRINTK("      %d MHz ",  PIXEL_CLOCK/1000000);

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
