From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] fbcon: Fix limited scroll in
	SCROLL_PAN_REDRAW mode
Date: Tue, 06 Jun 2006 19:09:11 +0800
Message-ID: <44856257.3080707@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fo56Z-0001Wt-VN for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Jun 2006 13:58:20 -0700
Received: from wx-out-0102.google.com ([66.249.82.199])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fo56Y-0007fp-Hr
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Jun 2006 13:58:20 -0700
Received: by wx-out-0102.google.com with SMTP id h29so181465wxd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 07 Jun 2006 13:58:17 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Malcom Parsons <malcolm.parsons@gmail.com>

When scrolling up in SCROLL_PAN_REDRAW mode with a large limited scroll
region, the bottom few lines have to be redrawn.  Without this patch,
the wrong text is drawn into these lines, corrupting the display.

Observed in 2.6.14 when running an IRC client in the Nintendo DS linux
port.

I haven't tested if scrolling down has the same problem.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/fbcon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index b910eff..4b7be68 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -1751,7 +1751,7 @@ static int fbcon_scroll(struct vc_data *
 					fbcon_redraw_move(vc, p, 0, t, count);
 				ypan_up_redraw(vc, t, count);
 				if (vc->vc_rows - b > 0)
-					fbcon_redraw_move(vc, p, b - count,
+					fbcon_redraw_move(vc, p, b,
 							  vc->vc_rows - b, b);
 			} else
 				fbcon_redraw_move(vc, p, t + count, b - t - count, t);
