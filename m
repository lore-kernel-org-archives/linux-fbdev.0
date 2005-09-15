From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 2/3] vgacon: Fix sanity checking in vgacon_resize
Date: Thu, 15 Sep 2005 21:14:56 +0800
Message-ID: <432973D0.4090404@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EFu6S-0005jO-26
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 15 Sep 2005 06:48:40 -0700
Received: from zproxy.gmail.com ([64.233.162.207])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EFu6Q-0003AS-VX
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 15 Sep 2005 06:48:40 -0700
Received: by zproxy.gmail.com with SMTP id r28so225576nza
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 15 Sep 2005 06:48:33 -0700 (PDT)
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

Reported by: walt <wa1ter@myrealbox.com>

"I routinely switch the console font during bootup to
8x8 so I can get 50 lines per screen.  Until 09 Sept,
just changing to the small font automatically gave me
all 50 lines -- but now I'm only getting 25 lines even
with the small font.  The bottom half of the screen
displays the text that already scrolled off the top."

This bug is due to an erroneous check in the recently added hook,
vgacon_resize(). It checks the new height against the original number of
rows of the console. Because the original number of rows depends on both
the scanline and the font height, check it instead against the
scanline/fontheight.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 vgacon.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)


diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -1020,7 +1020,9 @@ static int vgacon_font_get(struct vc_dat
 static int vgacon_resize(struct vc_data *c, unsigned int width,
 				unsigned int height)
 {
-	if (width % 2 || width > ORIG_VIDEO_COLS || height > ORIG_VIDEO_LINES)
+	if (width % 2 || width > ORIG_VIDEO_COLS ||
+	    height > (ORIG_VIDEO_LINES * vga_default_font_height)/
+	    c->vc_font.height)
 		return -EINVAL;
 
 	if (CON_IS_VISIBLE(c) && !vga_is_gfx) /* who knows */



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
