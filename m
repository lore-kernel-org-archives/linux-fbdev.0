From: Henry Nestler <henry.nestler@gmail.com>
Subject: [PATCH 3/4] fbcon: Bugfix soft cursor detection
	in Tile Blitting
Date: Wed, 2 Dec 2009 03:52:56 +0100
Message-ID: <5b77f61c0912011852u226c741fwd1a8011fee9cec90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <henry.nestler@gmail.com>) id 1NFfL2-0004ga-5V
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 Dec 2009 02:53:08 +0000
Received: from ey-out-1920.google.com ([74.125.78.147])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NFfKx-0000uI-Jx for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 Dec 2009 02:53:08 +0000
Received: by ey-out-1920.google.com with SMTP id 3so1151208eyh.40
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 01 Dec 2009 18:52:56 -0800 (PST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: geert@linux-m68k.org
Cc: trivial@kernel.org, linux-fbdev-devel@lists.sourceforge.net

from: Henry Nestler <henry.nestler@gmail.com>

Use mask 0x10 for "soft cursor" detection on in function tile_cursor.
(Tile Blitting Operation in framebuffer console).

The old mask 0x01 for vc_cursor_type detects CUR_NONE, CUR_LOWER_THIRD
and every second mode value as "software cursor". This hides the cursor
for these modes (cursor.mode = 0). But, only CUR_NONE or "software cursor"
should hide the cursor.

Signed-off-by: Henry Nestler <henry.nestler@gmail.com>
---
Kernel version 2.6.32-rc8

 drivers/video/console/tileblit.c        |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/console/tileblit.c b/drivers/video/console/tileblit.c
index 0056a41..15e8e1a 100644
--- a/drivers/video/console/tileblit.c
+++ b/drivers/video/console/tileblit.c
@@ -83,7 +83,7 @@ static void tile_cursor(struct vc_data *vc, struct
fb_info *info, int mode,
 			int softback_lines, int fg, int bg)
 {
 	struct fb_tilecursor cursor;
-	int use_sw = (vc->vc_cursor_type & 0x01);
+	int use_sw = (vc->vc_cursor_type & 0x10);

 	cursor.sx = vc->vc_x;
 	cursor.sy = vc->vc_y;
===

------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
