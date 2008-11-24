From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: [PATCH] Fix FB console blanking
Date: Mon, 24 Nov 2008 19:07:30 +0300
Message-ID: <1227542850-25928-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dbaryshkov@gmail.com>) id 1L4dyu-0006Yt-Kn
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Nov 2008 16:08:12 +0000
Received: from mu-out-0910.google.com ([209.85.134.190])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1L4dyq-0006zY-GH for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Nov 2008 16:08:12 +0000
Received: by mu-out-0910.google.com with SMTP id w1so2686525mue.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 24 Nov 2008 08:08:07 -0800 (PST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>

The commit aef7db4bd5a3b6068dfa05919a3d685199eed116 fixed the problem
with recursive locking in fb blanking code if blank is caused by user
setting the /sys/class/graphics/fb*/blank. However this broke the fbcon
timeout blanking.

Restore fbcon blanking and at the same time apply the proper fix for the
above problem: if fbcon_blank is called with FBINFO_FLAG_USEREVENT, we
are already called through notification from fb_blank, thus we don't
have to blank the fb again.

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
---
 drivers/video/console/fbcon.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 9cbff84..2f2f0f9 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -2400,16 +2400,13 @@ static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch)
 
  	if (!fbcon_is_inactive(vc, info)) {
 		if (ops->blank_state != blank) {
-			int ret = 1;
-
 			ops->blank_state = blank;
 			fbcon_cursor(vc, blank ? CM_ERASE : CM_DRAW);
 			ops->cursor_flash = (!blank);
 
-			if (info->fbops->fb_blank)
-				ret = info->fbops->fb_blank(blank, info);
-			if (ret)
-				fbcon_generic_blank(vc, info, blank);
+			if (!(info->flags & FBINFO_MISC_USEREVENT))
+				if (fb_blank(info, blank))
+					fbcon_generic_blank(vc, info, blank);
 		}
 
 		if (!blank)
-- 
1.5.6.5


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
