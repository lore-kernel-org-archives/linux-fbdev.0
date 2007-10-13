From: Antonino Daplas <adaplas@gmail.com>
Subject: [PATCH 14/15] fbcon: Delay the start of the
 cursor timer until a con_switch()
Date: Sat, 13 Oct 2007 08:32:43 +0800
Message-ID: <4710122B.6020501@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IgV4B-0005vE-Db for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Oct 2007 17:41:19 -0700
Received: from rv-out-0910.google.com ([209.85.198.191])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IgUyz-0002xt-Og
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Oct 2007 17:35:57 -0700
Received: by rv-out-0910.google.com with SMTP id g11so3588679rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 12 Oct 2007 17:35:57 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

As reported in Bugzilla Bug 9093, upon switching to X, a small rectangular
cursor can still be seen blinking in the upper left part of the screen. It is
fbcon's text cursor.  This is caused by a strange ioctl(..., KDSETMODE,
KD_TEXT) call done by something in userspace, perhaps by X itself, while the
tty is still in graphics mode. And when the tty is in KD_TEXT mode, the cursor
timer is restarted.

Although this is a userspace problem, we can work around it by delaying the
restart of the cursor timer until an fbcon_switch() is called. In other words,
the cursor timer will not be restarted even if a KD_TEXT mode switch is
requested.

Regression potential: Present but low

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/console/fbcon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 97a0224..0f32f4a 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -2405,7 +2405,7 @@ static int fbcon_blank(struct vc_data *v
 			update_screen(vc);
 	}
 
-	if (fbcon_is_inactive(vc, info) ||
+	if (mode_switch || fbcon_is_inactive(vc, info) ||
 	    ops->blank_state != FB_BLANK_UNBLANK)
 		fbcon_del_cursor_timer(info);
 	else


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
