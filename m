From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH resend] vt: fix potential race in
	VT_WAITACTIVE handler
Date: Sun, 1 Apr 2007 14:43:23 +0200
Message-ID: <20070401124323.GA4040@spock.one.pl>
Reply-To: spock@gentoo.org, linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HXzP5-0000dQ-W2 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 01 Apr 2007 05:43:28 -0700
Received: from ipn26-148.piekary.net ([83.238.26.148])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HXzP4-0004lT-GY
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 01 Apr 2007 05:43:27 -0700
Content-Disposition: inline
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
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>

From: Michal Januszewski <spock@gentoo.org>

On a multiprocessor machine the VT_WAITACTIVE ioctl call may return 0
if fg_console has already been updated in redraw_screen() but the
console switch itself hasn't been completed. Fix this by checking
fg_console in vt_waitactive() with the console sem held.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
---
This is the 2nd version of this patch. It incorporates Andrew's
suggestions, ie. calls set_current_state() after down() and adds
a comment explaining why acquiring the console sem is necessary.

 drivers/char/vt_ioctl.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/char/vt_ioctl.c b/drivers/char/vt_ioctl.c
index 1fa2da8..0508293 100644
--- a/drivers/char/vt_ioctl.c
+++ b/drivers/char/vt_ioctl.c
@@ -1039,10 +1039,20 @@ int vt_waitactive(int vt)
 
 	add_wait_queue(&vt_activate_queue, &wait);
 	for (;;) {
-		set_current_state(TASK_INTERRUPTIBLE);
 		retval = 0;
-		if (vt == fg_console)
+
+		/* Synchronize with redraw_screen(). By acquiring the console
+		 * semaphore we make sure that the console switch is completed
+		 * before we return. If we didn't wait for the semaphore, we
+		 * could return at a point where fg_console has already been
+		 * updated, but the console switch hasn't been completed. */
+		acquire_console_sem();
+		set_current_state(TASK_INTERRUPTIBLE);
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
