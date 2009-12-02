From: Henry Nestler <henry.nestler@gmail.com>
Subject: [PATCH 4/4] fbcon: Replace vc_cursor_type mask
	0x10 with CUR_USE_SW
Date: Wed, 2 Dec 2009 03:59:43 +0100
Message-ID: <5b77f61c0912011859h83dad7bvb96fba5249c678dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <henry.nestler@gmail.com>) id 1NFfRc-00051O-B2
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 Dec 2009 02:59:56 +0000
Received: from mail-ew0-f211.google.com ([209.85.219.211])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NFfRW-0008S8-J4 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 Dec 2009 02:59:56 +0000
Received: by ewy3 with SMTP id 3so9901350ewy.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 01 Dec 2009 18:59:44 -0800 (PST)
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

Replace hard coded vc_cursor_type mask 0x10 with macro CUR_USE_SW.

Signed-off-by: Henry Nestler <henry.nestler@gmail.com>
---

This patch depends on [patch 3/4], because it used new macro CUR_USE_SW 0x10.

Kernel version 2.6.32-rc8

 drivers/video/console/tileblit.c        |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/console/tileblit.c b/drivers/video/console/tileblit.c
--- a/drivers/video/console/tileblit.c
+++ b/drivers/video/console/tileblit.c
@@ -83,7 +83,7 @@ static void tile_cursor(struct vc_data *vc, struct
fb_info *info, int mode,
 			int softback_lines, int fg, int bg)
 {
 	struct fb_tilecursor cursor;
-	int use_sw = (vc->vc_cursor_type & 0x10);
+	int use_sw = (vc->vc_cursor_type & CUR_USE_SW);

 	cursor.sx = vc->vc_x;
 	cursor.sy = vc->vc_y;
===

------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
