From: akpm@osdl.org
Subject: [patch 157/160] fbcon: don't repaint the cursor when it is disabled.
Date: Wed, 27 Jul 2005 11:46:06 -0700
Message-ID: <200507271847.j6RIl3mT005867@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DxqwJ-0007jS-7w
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Jul 2005 11:47:35 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1Dxqw8-0006FU-Pb
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Jul 2005 11:47:35 -0700
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@osdl.org
Cc: akpm@osdl.org, spock@gentoo.org, linux-fbdev-devel@lists.sourceforge.net


From: Michal Januszewski <spock@gentoo.org>

Currently even when the cursor is disabled (`setterm -cursor off`), it is
still repainted as a black rectangle the size of a single char.  This can
be seen, for example, by chvt'ing to a free tty, disabling the cursor and
doing `dd if=3D/dev/urandom of=3D/dev/fb0`.

The patch changes this behaviour by avoiding painting anything when the
cursor is disabled.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
Cc: <linux-fbdev-devel@lists.sourceforge.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/video/console/fbcon.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN drivers/video/console/fbcon.c~dont-repaint-the-cursor-when-it-is-disabled drivers/video/console/fbcon.c
--- devel/drivers/video/console/fbcon.c~dont-repaint-the-cursor-when-it-is-disabled	2005-07-27 11:10:12.000000000 -0700
+++ devel-akpm/drivers/video/console/fbcon.c	2005-07-27 11:10:12.000000000 -0700
@@ -275,7 +275,8 @@ static void fb_flashcursor(void *private
 
 	if (!vc || !CON_IS_VISIBLE(vc) ||
 	    fbcon_is_inactive(vc, info) ||
- 	    registered_fb[con2fb_map[vc->vc_num]] != info)
+ 	    registered_fb[con2fb_map[vc->vc_num]] != info ||
+	    vc_cons[ops->currcon].d->vc_deccm != 1)
 		return;
 	acquire_console_sem();
 	p = &fb_display[vc->vc_num];
_


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
