From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 2/11] fbcon: Catch blank events on both device and console level
Date: Thu, 13 Jan 2005 21:01:23 +0800
Message-ID: <20050113214615.59AE01A0184@smtp-1.hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CpCnc-00013w-41
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 Jan 2005 13:46:36 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CpCnb-0008Vz-Jy
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 Jan 2005 13:46:35 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 2FDEAC7CD77
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 13 Jan 2005 21:46:19 +0000 (UTC)
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

  Call fb_blank() instead of info->fbops->fb_blank() to capture events on both
  device and console level.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 fbcon.c |   19 ++++++++-----------
 1 files changed, 8 insertions(+), 11 deletions(-)

diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	2005-01-12 06:10:17 +08:00
+++ b/drivers/video/console/fbcon.c	2005-01-13 19:39:19 +08:00
@@ -2014,6 +2014,7 @@
 static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fbcon_ops *ops = info->fbcon_par;
 	int active = !fbcon_is_inactive(vc, info);
 
 	if (mode_switch) {
@@ -2037,18 +2038,14 @@
 	}
 
  	if (active) {
-		struct fbcon_ops *ops = info->fbcon_par;
+		if (ops->blank_state != blank) {
+			ops->blank_state = blank;
+			fbcon_cursor(vc, blank ? CM_ERASE : CM_DRAW);
+			ops->cursor_flash = (!blank);
 
- 		fbcon_cursor(vc, blank ? CM_ERASE : CM_DRAW);
- 		ops->cursor_flash = (!blank);
-
- 		if (ops->blank_state != blank) {
- 			if (info->fbops->fb_blank &&
- 			    info->fbops->fb_blank(blank, info))
- 				fbcon_generic_blank(vc, info, blank);
-
- 			ops->blank_state = blank;
- 		}
+			if (fb_blank(info, blank))
+				fbcon_generic_blank(vc, info, blank);
+		}
 
  		if (!blank)
  			update_screen(vc->vc_num);




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
