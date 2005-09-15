From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 3/3] vc: Use correct size on buffer copy in vc_resize
Date: Thu, 15 Sep 2005 21:34:33 +0800
Message-ID: <43297869.5030108@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EFu6b-0005ju-OH
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 15 Sep 2005 06:48:49 -0700
Received: from zproxy.gmail.com ([64.233.162.192])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EFu6b-0003Oz-Js
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 15 Sep 2005 06:48:49 -0700
Received: by zproxy.gmail.com with SMTP id i11so272531nzh
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 15 Sep 2005 06:48:48 -0700 (PDT)
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
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

In the unlikely case of the new screen width much wider then the old,
use (old_row_size * new_rows) instead of new_screen_size to prevent a
buffer overrun during the copy.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 vt.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)


diff --git a/drivers/char/vt.c b/drivers/char/vt.c
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -810,13 +810,14 @@ int vc_resize(struct vc_data *vc, unsign
 			 * from the top and bottom of cursor position
 			 */
 			old_origin += (vc->vc_y - new_rows/2) * old_row_size;
-			end = old_origin + new_screen_size;
+			end = old_origin + (old_row_size * new_rows);
 		}
 	} else
 		/*
 		 * Cursor near the top, copy contents from the top of buffer
 		 */
-		end = (old_rows > new_rows) ? old_origin + new_screen_size :
+		end = (old_rows > new_rows) ? old_origin +
+			(old_row_size * new_rows) :
 			vc->vc_scr_end;
 
 	update_attr(vc);



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
