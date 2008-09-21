From: Marcin Slusarz <marcin.slusarz@gmail.com>
Subject: [PATCH 1/2] vgacon: optimize scrolling
Date: Sun, 21 Sep 2008 18:00:08 +0200
Message-ID: <1222012809-5783-2-git-send-email-marcin.slusarz@gmail.com>
References: <1222012809-5783-1-git-send-email-marcin.slusarz@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753215AbYIUQBU@vger.kernel.org>
In-Reply-To: <1222012809-5783-1-git-send-email-marcin.slusarz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Antonino Daplas <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net

Join multiple scr_memcpyw into 1-3 calls (usually 2).
(benchmarked average speedup: 1%)

Signed-off-by: Marcin Slusarz <marcin.slusarz@gmail.com>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net
---
 drivers/video/console/vgacon.c |   28 ++++++++++++++++------------
 1 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index bd1f57b..de4f66c 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -292,23 +292,27 @@ static int vgacon_scrolldelta(struct vc_data *c, int lines)
 	d = (void *) c->vc_origin;
 	s = (void *) c->vc_screenbuf;
 
-	while (count--) {
-		scr_memcpyw(d, vgacon_scrollback + soff, c->vc_size_row);
-		d += c->vc_size_row;
-		soff += c->vc_size_row;
-
-		if (soff >= vgacon_scrollback_size)
-			soff = 0;
+	if (count) {
+		int copysize;
+		count *= c->vc_size_row;
+		/* how much memory to end of buffer left? */
+		copysize = min(count, vgacon_scrollback_size - soff);
+		scr_memcpyw(d, vgacon_scrollback + soff, copysize);
+		d += copysize;
+		count -= copysize;
+		
+		if (count) {
+			copysize = min(count, vgacon_scrollback_size);
+			scr_memcpyw(d, vgacon_scrollback, copysize);
+			d += copysize;
+		}
 	}
 
 	if (diff == c->vc_rows) {
 		vgacon_cursor(c, CM_MOVE);
 	} else {
-		while (diff--) {
-			scr_memcpyw(d, s, c->vc_size_row);
-			d += c->vc_size_row;
-			s += c->vc_size_row;
-		}
+		if (diff)
+			scr_memcpyw(d, s, diff * c->vc_size_row);
 	}
 
 	return 1;
-- 
1.5.6.4
