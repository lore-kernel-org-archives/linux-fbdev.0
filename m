From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 08/10] fbcon: smart blitter usage for
	scrolling
Date: Thu, 17 May 2007 05:33:04 +0800
Message-ID: <464B7890.80502@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HoRA1-0005wJ-Of for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 May 2007 14:35:54 -0700
Received: from wr-out-0506.google.com ([64.233.184.224])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HoRA1-0003Tr-4l
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 May 2007 14:35:53 -0700
Received: by wr-out-0506.google.com with SMTP id i20so716473wra
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 16 May 2007 14:35:52 -0700 (PDT)
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

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch replaces the current SCROLL_MOVE method with smarter
method using the same logic as the SCROLL_REDRAW method. This
brings these two methods much closer in performance and benefits
all framebuffers which uses the SCROLL_MOVE method.

[adaplas]
- remove unnecessary char attribute checking
- whitespace cleanups and 80-column line fixes

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/console/fbcon.c |   76 +++++++++++++++++++++++++++++++++++++----
 1 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 73813c6..7888e31 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -1704,6 +1704,56 @@ static void fbcon_redraw_move(struct vc_
 	}
 }
 
+static void fbcon_redraw_blit(struct vc_data *vc, struct fb_info *info,
+			struct display *p, int line, int count, int ycount)
+{
+	int offset = ycount * vc->vc_cols;
+	unsigned short *d = (unsigned short *)
+	    (vc->vc_origin + vc->vc_size_row * line);
+	unsigned short *s = d + offset;
+	struct fbcon_ops *ops = info->fbcon_par;
+
+	while (count--) {
+		unsigned short *start = s;
+		unsigned short *le = advance_row(s, 1);
+		unsigned short c;
+		int x = 0;
+
+		do {
+			c = scr_readw(s);
+
+			if (c == scr_readw(d)) {
+				if (s > start) {
+					ops->bmove(vc, info, line + ycount, x,
+						   line, x, 1, s-start);
+					x += s - start + 1;
+					start = s + 1;
+				} else {
+					x++;
+					start++;
+				}
+			}
+
+			scr_writew(c, d);
+			console_conditional_schedule();
+			s++;
+			d++;
+		} while (s < le);
+		if (s > start)
+			ops->bmove(vc, info, line + ycount, x, line, x, 1,
+				   s-start);
+		console_conditional_schedule();
+		if (ycount > 0)
+			line++;
+		else {
+			line--;
+			/* NOTE: We subtract two lines from these pointers */
+			s -= vc->vc_size_row;
+			d -= vc->vc_size_row;
+		}
+	}
+}
+
 static void fbcon_redraw(struct vc_data *vc, struct display *p,
 			 int line, int count, int offset)
 {
@@ -1789,7 +1839,6 @@ static int fbcon_scroll(struct vc_data *
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
-	struct fbcon_ops *ops = info->fbcon_par;
 	int scroll_partial = info->flags & FBINFO_PARTIAL_PAN_OK;
 
 	if (fbcon_is_inactive(vc, info))
@@ -1813,10 +1862,15 @@ static int fbcon_scroll(struct vc_data *
 			goto redraw_up;
 		switch (p->scrollmode) {
 		case SCROLL_MOVE:
-			ops->bmove(vc, info, t + count, 0, t, 0,
-				    b - t - count, vc->vc_cols);
-			ops->clear(vc, info, b - count, 0, count,
-				  vc->vc_cols);
+			fbcon_redraw_blit(vc, info, p, t, b - t - count,
+				     count);
+			fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
+			scr_memsetw((unsigned short *) (vc->vc_origin +
+							vc->vc_size_row *
+							(b - count)),
+				    vc->vc_video_erase_char,
+				    vc->vc_size_row * count);
+			return 1;
 			break;
 
 		case SCROLL_WRAP_MOVE:
@@ -1899,9 +1953,15 @@ static int fbcon_scroll(struct vc_data *
 			goto redraw_down;
 		switch (p->scrollmode) {
 		case SCROLL_MOVE:
-			ops->bmove(vc, info, t, 0, t + count, 0,
-				    b - t - count, vc->vc_cols);
-			ops->clear(vc, info, t, 0, count, vc->vc_cols);
+			fbcon_redraw_blit(vc, info, p, b - 1, b - t - count,
+				     -count);
+			fbcon_clear(vc, t, 0, count, vc->vc_cols);
+			scr_memsetw((unsigned short *) (vc->vc_origin +
+							vc->vc_size_row *
+							t),
+				    vc->vc_video_erase_char,
+				    vc->vc_size_row * count);
+			return 1;
 			break;
 
 		case SCROLL_WRAP_MOVE:



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
