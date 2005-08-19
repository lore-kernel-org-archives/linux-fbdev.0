From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 7/9]  console: Fix buffer copy on vc resize
Date: Sat, 20 Aug 2005 00:47:46 +0800
Message-ID: <43060D32.7080502@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E6HHh-0002Pk-9p
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Aug 2005 17:32:29 -0700
Received: from wproxy.gmail.com ([64.233.184.201])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E6HHf-0000uI-Uo
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Aug 2005 17:32:29 -0700
Received: by wproxy.gmail.com with SMTP id i21so610631wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 19 Aug 2005 17:32:22 -0700 (PDT)
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

    On a vc resize, the contents of the old screen buffer are transferred to the
    new screenbuffer.  If the new screenbuffer is smaller than the old one, only
    the contents from the bottom are copied to new.  If the contents of the
    old buffer are located at the top, then the contents will not be copied to
    the new buffer resulting in a blank screen.

    This bug will happen only if the vc in question is not in the foreground.
    Doing an fbset -a or con2fbmap will trigger this bug.

    To fix this problem, base the start of the copy from the location of the
    current cursor.  If the cursor is near the top of the buffer, copy the
    contents at the top, and if the cursor is near the bottom of the buffer, then
    copy the contents at the bottom. In the unlikely case where the new row
    size is greater than 2x smaller than the old one, and the cursor is in the
    middle, copy 1/2 screenful from the top and bottom of the cursor position.

    Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 vt.c |   37 +++++++++++++++++++++++++++++++------
 1 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/char/vt.c b/drivers/char/vt.c
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -751,6 +751,7 @@ int vc_resize(struct vc_data *vc, unsign
 	unsigned long old_origin, new_origin, new_scr_end, rlth, rrem, err = 0;
 	unsigned int old_cols, old_rows, old_row_size, old_screen_size;
 	unsigned int new_cols, new_rows, new_row_size, new_screen_size;
+	unsigned int end;
 	unsigned short *newscreen;
 
 	WARN_CONSOLE_UNLOCKED();
@@ -794,20 +795,44 @@ int vc_resize(struct vc_data *vc, unsign
 	old_origin = vc->vc_origin;
 	new_origin = (long) newscreen;
 	new_scr_end = new_origin + new_screen_size;
-	if (new_rows < old_rows)
-		old_origin += (old_rows - new_rows) * old_row_size;
+
+	if (vc->vc_y > new_rows) {
+		if (old_rows - vc->vc_y < new_rows) {
+			/*
+			 * Cursor near the bottom, copy contents from the
+			 * bottom of buffer
+			 */
+			old_origin += (old_rows - new_rows) * old_row_size;
+			end = vc->vc_scr_end;
+		} else {
+			/*
+			 * Cursor is in no man's land, copy 1/2 screenful
+			 * from the top and bottom of cursor position
+			 */
+			old_origin += (vc->vc_y - new_rows/2) * old_row_size;
+			end = old_origin + new_screen_size;
+		}
+	} else
+		/*
+		 * Cursor near the top, copy contents from the top of buffer
+		 */
+		end = (old_rows > new_rows) ? old_origin + new_screen_size :
+			vc->vc_scr_end;
 
 	update_attr(vc);
 
-	while (old_origin < vc->vc_scr_end) {
-		scr_memcpyw((unsigned short *) new_origin, (unsigned short *) old_origin, rlth);
+	while (old_origin < end) {
+		scr_memcpyw((unsigned short *) new_origin,
+			    (unsigned short *) old_origin, rlth);
 		if (rrem)
-			scr_memsetw((void *)(new_origin + rlth), vc->vc_video_erase_char, rrem);
+			scr_memsetw((void *)(new_origin + rlth),
+				    vc->vc_video_erase_char, rrem);
 		old_origin += old_row_size;
 		new_origin += new_row_size;
 	}
 	if (new_scr_end > new_origin)
-		scr_memsetw((void *)new_origin, vc->vc_video_erase_char, new_scr_end - new_origin);
+		scr_memsetw((void *)new_origin, vc->vc_video_erase_char,
+			    new_scr_end - new_origin);
 	if (vc->vc_kmalloced)
 		kfree(vc->vc_screenbuf);
 	vc->vc_screenbuf = newscreen;



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
