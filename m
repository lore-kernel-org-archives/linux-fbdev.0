From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 1/4] fbdev: Fix screen corruption in neofb
Date: Mon, 22 Nov 2004 07:16:45 +0800
Message-ID: <200411220716.48307.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CW10Q-0002XT-NI
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 21 Nov 2004 15:20:30 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CW102-0005SH-Uz
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 21 Nov 2004 15:20:30 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id AE1869777E4
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 21 Nov 2004 23:19:51 +0000 (UTC)
Content-Disposition: inline
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
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

This patch fixes the screen corruption resulting from neofb cleanup.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 neofb.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff -Nru a/drivers/video/neofb.c b/drivers/video/neofb.c
--- a/drivers/video/neofb.c	2004-11-10 06:15:06 +08:00
+++ b/drivers/video/neofb.c	2004-11-20 09:25:43 +08:00
@@ -1481,7 +1481,7 @@
 	int s_pitch = (image->width * image->depth + 7) >> 3;
 	int scan_align = info->pixmap.scan_align - 1;
 	int buf_align = info->pixmap.buf_align - 1;
-	int bltCntl_flags, d_pitch, data_len, i;
+	int bltCntl_flags, d_pitch, data_len;
 
 	// The data is padded for the hardware
 	d_pitch = (s_pitch + scan_align) & ~scan_align;
@@ -1533,8 +1533,7 @@
 	writel((image->height << 16) | (image->width & 0xffff),
 	       &par->neo2200->xyExt);
 
-	for (i = 0; i < data_len; i++)
-		writeb(image->data[i], par->mmio_vbase + 0x100000 + i);
+	memcpy_toio(par->mmio_vbase + 0x100000, image->data, data_len);
 }
 
 static void




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
