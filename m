From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 2/2] intelfb/fbdev: Save info->flags in a local variable
Date: Mon, 15 Aug 2005 21:29:11 +0800
Message-ID: <430098A7.1080102@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E4fAN-00067S-4A
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Aug 2005 06:38:15 -0700
Received: from zproxy.gmail.com ([64.233.162.192])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E4fAL-0001Kz-Us
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Aug 2005 06:38:15 -0700
Received: by zproxy.gmail.com with SMTP id s18so704411nze
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Aug 2005 06:38:07 -0700 (PDT)
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Sylvain Meyer <sylvain.meyer@worldonline.fr>, Pavel Kysilka <goldenfish@bsys.cz>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

  Reported by: Pavel Kysilka (Bugzilla Bug 5059)

  Problem Description:
  intelfb driver do not keep resolution set with fbset after switching to anot
  console and back.

  Steps to reproduce:
  initial options: tty1,tty2 - 1024x768-60
  1) tty1 - fbset after booting (1024x768-60)
  2) tty1 - fbset 800x600-100
  tty1: 800x600-100
  3) swith to tty2, swith to tty1
  tty1: 1024x768-60 (the same resolution as default from kernel booting)

  This bug is caused by intelfb unintentionally destroying info->flags in
  set_par(). Therefore the flag, FBINFO_MISC_USEREVENT used to notify
  fbcon of a mode change was cleared causing the above problem. This bug
  though is not intelfb specific, as other drivers may also be affected.

  The fix is to save info->flags in a local variable before calling any
  of the driver hooks.  A more definitive fix (for post 2.6.13) is to
  separate info->flags into one that is set by the driver and another that
  is set by core fbdev/fbcon.

  Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

fbmem.c |    6 +++---
1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -643,8 +643,8 @@ fb_pan_display(struct fb_info *info, str
 int
 fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 {
-	int err;
-
+	int err, flags = info->flags;
+
 	if (var->activate & FB_ACTIVATE_INV_MODE) {
 		struct fb_videomode mode1, mode2;
 		int ret = 0;
@@ -697,7 +697,7 @@ fb_set_var(struct fb_info *info, struct 
 			    !list_empty(&info->modelist))
 				err = fb_add_videomode(&mode, &info->modelist);
 
-			if (!err && info->flags & FBINFO_MISC_USEREVENT) {
+			if (!err && flags & FBINFO_MISC_USEREVENT) {
 				struct fb_event event;
 				int evnt = (var->activate & FB_ACTIVATE_ALL) ?
 					FB_EVENT_MODE_CHANGE_ALL :




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
