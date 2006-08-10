From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/8] fbcon: Remove cursor timer if unused
Date: Thu, 10 Aug 2006 19:47:20 +0800
Message-ID: <44DB1CC8.3000302@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GB9AP-0003Cg-TI for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 Aug 2006 04:57:38 -0700
Received: from nz-out-0102.google.com ([64.233.162.196])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GB9AM-0006Ho-KY
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 Aug 2006 04:57:37 -0700
Received: by nz-out-0102.google.com with SMTP id m22so116768nzf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 10 Aug 2006 04:57:32 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Remove the cursor timer (cursor flashing) on the following conditions:

- if vc is in KD_GRAPHICS mode, ie, when X owns the console
- if vc is blanked

This misbehavior was exposed by Dave Jones.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/fbcon.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 6165fd9..cf4c999 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -396,9 +396,8 @@ static void fb_flashcursor(void *private
 		vc = vc_cons[ops->currcon].d;
 
 	if (!vc || !CON_IS_VISIBLE(vc) ||
-	    fbcon_is_inactive(vc, info) ||
  	    registered_fb[con2fb_map[vc->vc_num]] != info ||
-	    vc_cons[ops->currcon].d->vc_deccm != 1) {
+	    vc->vc_deccm != 1) {
 		release_console_sem();
 		return;
 	}
@@ -2166,7 +2165,12 @@ static int fbcon_switch(struct vc_data *
 			fbcon_del_cursor_timer(old_info);
 	}
 
-	fbcon_add_cursor_timer(info);
+	if (fbcon_is_inactive(vc, info) ||
+	    ops->blank_state != FB_BLANK_UNBLANK)
+		fbcon_del_cursor_timer(info);
+	else
+		fbcon_add_cursor_timer(info);
+
 	set_blitting_type(vc, info);
 	ops->cursor_reset = 1;
 
@@ -2276,10 +2280,11 @@ static int fbcon_blank(struct vc_data *v
 			update_screen(vc);
 	}
 
-	if (!blank)
-		fbcon_add_cursor_timer(info);
-	else
+	if (fbcon_is_inactive(vc, info) ||
+	    ops->blank_state != FB_BLANK_UNBLANK)
 		fbcon_del_cursor_timer(info);
+	else
+		fbcon_add_cursor_timer(info);
 
 	return 0;
 }


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
