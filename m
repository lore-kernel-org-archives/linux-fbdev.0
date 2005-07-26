From: akpm@osdl.org
Subject: dont-repaint-the-cursor-when-it-is-disabled.patch added to -mm tree
Date: Mon, 25 Jul 2005 19:45:29 -0700
Message-ID: <200507260246.j6Q2kOME026750@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DxFSi-0001UV-8x
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 25 Jul 2005 19:46:32 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1DxFSh-0008VH-2V
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 25 Jul 2005 19:46:32 -0700
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
To: spock@gentoo.org, linux-fbdev-devel@lists.sourceforge.net, mm-commits@vger.kernel.org


The patch titled

     fbcon: don't repaint the cursor when it is disabled.

has been added to the -mm tree.  Its filename is

     dont-repaint-the-cursor-when-it-is-disabled.patch

Patches currently in -mm which might be from spock@gentoo.org are

dont-repaint-the-cursor-when-it-is-disabled.patch



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
--- devel/drivers/video/console/fbcon.c~dont-repaint-the-cursor-when-it-is-disabled	2005-07-25 19:44:55.000000000 -0700
+++ devel-akpm/drivers/video/console/fbcon.c	2005-07-25 19:44:55.000000000 -0700
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
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
