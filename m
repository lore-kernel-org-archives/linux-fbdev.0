From: Geert.Uytterhoeven@sonycom.com
Subject: [patch 1/3] fbdev: Avoid vertical overflow when
	making space for the logo
Date: Tue, 13 Mar 2007 15:14:40 +0100
Message-ID: <20070313141512.172882000@sonycom.com>
References: <20070313141439.295232000@sonycom.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HR7o1-00075y-Kh for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 13 Mar 2007 07:16:49 -0700
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HR7nw-0000Va-Nw
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 13 Mar 2007 07:16:49 -0700
Content-Disposition: inline;
	filename=spe-logo/logo-avoid-vertical-overflow.diff
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
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>, Geoff Levand <geoffrey.levand@am.sony.com>, "Antonino A. Daplas" <adaplas@gmail.com>

fbcon_prepare_logo(): Avoid vertical overflow when making space for the logo

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Acked-By: James Simmons <jsimmons@infradead.org>
---
 drivers/video/console/fbcon.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

--- ps3-linux-2.6.21-rc3.orig/drivers/video/console/fbcon.c
+++ ps3-linux-2.6.21-rc3/drivers/video/console/fbcon.c
@@ -618,8 +618,13 @@ static void fbcon_prepare_logo(struct vc
 			r -= cols;
 		}
 		if (!save) {
-			vc->vc_y += logo_lines;
-			vc->vc_pos += logo_lines * vc->vc_size_row;
+			int lines;
+			if (vc->vc_y + logo_lines >= rows)
+				lines = rows - vc->vc_y - 1;
+			else
+				lines = logo_lines;
+			vc->vc_y += lines;
+			vc->vc_pos += lines * vc->vc_size_row;
 		}
 	}
 	scr_memsetw((unsigned short *) vc->vc_origin,

--
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
