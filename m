From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 07/18] fbcon: Avoid illegal display panning
Date: Sat, 10 Dec 2005 14:11:07 +0800
Message-ID: <439A717B.7010903@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eky4g-0002ow-Cv
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 22:19:14 -0800
Received: from zproxy.gmail.com ([64.233.162.194])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Eky4g-0004QR-3n
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 22:19:14 -0800
Received: by zproxy.gmail.com with SMTP id z31so1040737nzd
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 09 Dec 2005 22:19:13 -0800 (PST)
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

Avoid calls to fb_pan_display when driver is suspended or not
in text mode.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/fbcon.c |   25 +++++++++++++++++++------
 1 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 9678045..d089209 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -2136,8 +2136,12 @@ static int fbcon_switch(struct vc_data *
 
 	scrollback_max = 0;
 	scrollback_current = 0;
-	ops->var.xoffset = ops->var.yoffset = p->yscroll = 0;
-	ops->update_start(info);
+
+	if (!fbcon_is_inactive(vc, info)) {
+	    ops->var.xoffset = ops->var.yoffset = p->yscroll = 0;
+	    ops->update_start(info);
+	}
+
 	fbcon_set_palette(vc, color_table); 	
 	fbcon_clear_margins(vc, 0);
 
@@ -2736,8 +2740,12 @@ static void fbcon_modechanged(struct fb_
 		updatescrollmode(p, info, vc);
 		scrollback_max = 0;
 		scrollback_current = 0;
-		ops->var.xoffset = ops->var.yoffset = p->yscroll = 0;
-		ops->update_start(info);
+		
+		if (!fbcon_is_inactive(vc, info)) {
+		    ops->var.xoffset = ops->var.yoffset = p->yscroll = 0;
+		    ops->update_start(info);
+		}
+
 		fbcon_set_palette(vc, color_table);
 		update_screen(vc);
 		if (softback_buf)
@@ -2774,8 +2782,13 @@ static void fbcon_set_all_vcs(struct fb_
 			updatescrollmode(p, info, vc);
 			scrollback_max = 0;
 			scrollback_current = 0;
-			ops->var.xoffset = ops->var.yoffset = p->yscroll = 0;
-			ops->update_start(info);
+
+			if (!fbcon_is_inactive(vc, info)) {
+			    ops->var.xoffset = ops->var.yoffset =
+				p->yscroll = 0;
+			    ops->update_start(info);
+			}
+
 			fbcon_set_palette(vc, color_table);
 			update_screen(vc);
 			if (softback_buf)




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
