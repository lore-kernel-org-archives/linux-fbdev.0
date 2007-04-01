From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] vt: fix a potential race in the
	VT_WAITACTIVE handler
Date: Sun, 01 Apr 2007 17:34:46 +0800
Message-ID: <460F7CB6.10106@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HXwUG-0003Az-Uq for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 01 Apr 2007 02:36:37 -0700
Received: from nz-out-0506.google.com ([64.233.162.231])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HXwUF-0000qr-B9
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 01 Apr 2007 02:36:36 -0700
Received: by nz-out-0506.google.com with SMTP id i11so1525056nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 01 Apr 2007 02:36:34 -0700 (PDT)
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
Cc: Michal Januszewski <spock@gentoo.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Michal Januszewski <spock@gentoo.org>

On a multiprocessor machine the VT_WAITACTIVE ioctl call may return 0
if fg_console has already been updated in redraw_screen(), but the
console switch itself hasn't been completed. Fix this by checking
fg_console in vt_waitactive() with the console sem held.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/char/vt_ioctl.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/char/vt_ioctl.c b/drivers/char/vt_ioctl.c
index 1fa2da8..6db3088 100644
--- a/drivers/char/vt_ioctl.c
+++ b/drivers/char/vt_ioctl.c
@@ -1041,8 +1041,12 @@ int vt_waitactive(int vt)
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		retval = 0;
-		if (vt == fg_console)
+		acquire_console_sem();
+		if (vt == fg_console) {
+			release_console_sem();
 			break;
+		}
+		release_console_sem();
 		retval = -EINTR;
 		if (signal_pending(current))
 			break;


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
