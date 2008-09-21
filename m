From: Marcin Slusarz <marcin.slusarz@gmail.com>
Subject: [PATCH 2/2] vgacon: vgacon_scrolldelta simplification
Date: Sun, 21 Sep 2008 18:00:09 +0200
Message-ID: <1222012809-5783-3-git-send-email-marcin.slusarz@gmail.com>
References: <1222012809-5783-1-git-send-email-marcin.slusarz@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752506AbYIUQBf@vger.kernel.org>
In-Reply-To: <1222012809-5783-1-git-send-email-marcin.slusarz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Antonino Daplas <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net

There's no point in checking diff == c->vc_rows, because it can be true
only when count == 0, but we already checked that.
Additionally move variables used only in one block to this block.

Signed-off-by: Marcin Slusarz <marcin.slusarz@gmail.com>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net
---
 drivers/video/console/vgacon.c |   22 +++++++++-------------
 1 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index de4f66c..a785f99 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -239,8 +239,7 @@ static void vgacon_restore_screen(struct vc_data *c)
 
 static int vgacon_scrolldelta(struct vc_data *c, int lines)
 {
-	int start, end, count, soff, diff;
-	void *d, *s;
+	int start, end, count, soff;
 
 	if (!lines) {
 		c->vc_visible_origin = c->vc_origin;
@@ -287,13 +286,13 @@ static int vgacon_scrolldelta(struct vc_data *c, int lines)
 	if (count > c->vc_rows)
 		count = c->vc_rows;
 
-	diff = c->vc_rows - count;
-
-	d = (void *) c->vc_origin;
-	s = (void *) c->vc_screenbuf;
-
 	if (count) {
 		int copysize;
+		
+		int diff = c->vc_rows - count;
+		void *d = (void *) c->vc_origin;
+		void *s = (void *) c->vc_screenbuf;
+		
 		count *= c->vc_size_row;
 		/* how much memory to end of buffer left? */
 		copysize = min(count, vgacon_scrollback_size - soff);
@@ -306,14 +305,11 @@ static int vgacon_scrolldelta(struct vc_data *c, int lines)
 			scr_memcpyw(d, vgacon_scrollback, copysize);
 			d += copysize;
 		}
-	}
-
-	if (diff == c->vc_rows) {
-		vgacon_cursor(c, CM_MOVE);
-	} else {
+		
 		if (diff)
 			scr_memcpyw(d, s, diff * c->vc_size_row);
-	}
+	} else
+		vgacon_cursor(c, CM_MOVE);
 
 	return 1;
 }
-- 
1.5.6.4
