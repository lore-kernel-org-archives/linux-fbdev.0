From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 13/20] vgacon: Disallow console
 operations when in KD_GRAPHICS mode
Date: Sat, 05 May 2007 22:58:28 +0800
Message-ID: <463C9B94.10109@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HkMpJ-000405-54 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 09:09:48 -0700
Received: from py-out-1112.google.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HkME5-0008EN-Dg
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 08:31:13 -0700
Received: by py-out-1112.google.com with SMTP id a29so906538pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 05 May 2007 08:31:13 -0700 (PDT)
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

Reported by James Pearson as:

	 boot to run level 3

	 if not root, then make sure /dev/console is writeable

	 login and type:

	 setterm -blank 0

	 start X

	 type into an xterm:

	 while true; do echo "" > /dev/console; usleep 100000; done

	 while the above loop is running switch to the text console and back
	 again (Ctrl-Alt-F1 then Ctrl-Alt-F7)

	 ... and the screen will be shifting (and wrapping) to the left.

This problem stems from continuously writing text to the system console (which
is in KD_TEXT mode) while the foreground console is in KD_GRAPHICS
mode. Somewhere along the way, console printing got confused and omitted the
KD_GRAPHICS/KD_TEXT test.  Thus, vgacon attempted to scroll the screen of X,
which causes X to shift.

Fix by disallowing vgacon to touch the hardware when the vc is in KD_GRAPHICS
mode. A definitive fix entails a full audit of the console code.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>

Tony
---

 drivers/video/console/vgacon.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index d0d2733..2460b82 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -660,6 +660,9 @@ #endif
 
 static void vgacon_cursor(struct vc_data *c, int mode)
 {
+	if (c->vc_mode != KD_TEXT)
+		return;
+
 	vgacon_restore_screen(c);
 
 	switch (mode) {
@@ -1318,7 +1321,7 @@ static int vgacon_scroll(struct vc_data 
 	unsigned long oldo;
 	unsigned int delta;
 
-	if (t || b != c->vc_rows || vga_is_gfx)
+	if (t || b != c->vc_rows || vga_is_gfx || c->vc_mode != KD_TEXT)
 		return 0;
 
 	if (!vga_hardscroll_enabled || lines >= c->vc_rows / 2)


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
