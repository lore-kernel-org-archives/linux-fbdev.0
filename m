From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 02/20] fbcon: Check console-fb mapping
	in fbcon_get_requirement
Date: Sat, 05 May 2007 22:43:25 +0800
Message-ID: <463C980D.7000806@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HkMDD-0008Ut-T7 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 08:30:19 -0700
Received: from py-out-1112.google.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HkMDD-0008EN-HJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 08:30:19 -0700
Received: by py-out-1112.google.com with SMTP id a29so906538pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 05 May 2007 08:30:19 -0700 (PDT)
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

- Check the console-to-fb mapping in fbcon_get_requirement(), otherwise the
value returned may not be valid for the driver.

- Minor cleanup

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/console/fbcon.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 34899bd..73813c6 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -3048,14 +3048,14 @@ static void fbcon_get_requirement(struct
 {
 	struct vc_data *vc;
 	struct display *p;
-	int charcnt;
 
 	if (caps->flags) {
-		int i;
+		int i, charcnt;
 
 		for (i = first_fb_vc; i <= last_fb_vc; i++) {
 			vc = vc_cons[i].d;
-			if (vc && vc->vc_mode == KD_TEXT) {
+			if (vc && vc->vc_mode == KD_TEXT &&
+			    info->node == con2fb_map[i]) {
 				p = &fb_display[i];
 				caps->x |= 1 << (vc->vc_font.width - 1);
 				caps->y |= 1 << (vc->vc_font.height - 1);
@@ -3068,14 +3068,13 @@ static void fbcon_get_requirement(struct
 	} else {
 		vc = vc_cons[fg_console].d;
 
-		if (vc && vc->vc_mode == KD_TEXT) {
+		if (vc && vc->vc_mode == KD_TEXT &&
+		    info->node == con2fb_map[fg_console]) {
 			p = &fb_display[fg_console];
-			caps->x |= 1 << (vc->vc_font.width - 1);
-			caps->y |= 1 << (vc->vc_font.height - 1);
-			charcnt = (p->userfont) ?
+			caps->x = 1 << (vc->vc_font.width - 1);
+			caps->y = 1 << (vc->vc_font.height - 1);
+			caps->len = (p->userfont) ?
 				FNTCHARCNT(p->fontdata) : 256;
-			if (caps->len < charcnt)
-				caps->len = charcnt;
 		}
 	}
 }


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
