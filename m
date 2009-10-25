From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] savagefb: fix blanking mode on CRT
	display
Date: Sun, 25 Oct 2009 11:17:04 +0100
Message-ID: <20091025111704.3b0fe81d.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1N1ztF-0000fm-7M
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Oct 2009 09:59:57 +0000
Received: from smtp240.poczta.interia.pl ([217.74.64.240])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N1ztA-0005wF-Sm for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Oct 2009 09:59:57 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Fix wrong bit mask for blanking register.  Due to the error a CRT monitor blanks
off due to wrong frequency (out of range) instead of PM signal (vertical and horizontal
frequencies cut off).

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
Just compare the mask with bits set in the switch(blank) clause below the changed line.

diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
index 37b135d..5ad7c79 100644
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -1565,7 +1565,7 @@ static int savagefb_blank(int blank, struct fb_info *info)
 		vga_out8(0x3c5, sr8, par);
 		vga_out8(0x3c4, 0x0d, par);
 		srd = vga_in8(0x3c5, par);
-		srd &= 0x03;
+		srd &= 0x50;
 
 		switch (blank) {
 		case FB_BLANK_UNBLANK:

----------------------------------------------------------------------
Opony do 30% taniej, dostawa gratis!
http://link.interia.pl/f23c9



------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
