From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] asiliantfb: Fix pseudo_palette setup in asiliantfb_setcolreg()
Date: Thu, 23 Feb 2006 20:40:22 +0800
Message-ID: <43FDAD36.5040804@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FCNLv-0007m1-UV
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Feb 2006 12:46:19 -0800
Received: from pproxy.gmail.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FCNLt-0000Ra-Io
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Feb 2006 12:46:20 -0800
Received: by pproxy.gmail.com with SMTP id i49so174626pyi
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Feb 2006 12:46:16 -0800 (PST)
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
To: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

The setcolreg function will attempt to write 24 color entries to the
pseudo_pallette. However, the pseudo_palette has only space for 16
entries.

Thanks to Atsushi Nemoto for reporting this bug.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/asiliantfb.c |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/video/asiliantfb.c b/drivers/video/asiliantfb.c
index 69f7554..c924d81 100644
--- a/drivers/video/asiliantfb.c
+++ b/drivers/video/asiliantfb.c
@@ -322,32 +322,29 @@ static int asiliantfb_setcolreg(u_int re
 	writeb(green, mmio_base + 0x791);
 	writeb(blue, mmio_base + 0x791);
 
-	switch(p->var.bits_per_pixel) {
-	case 15:
-		if (regno < 16) {
+	if (regno < 16) {
+		switch(p->var.red.offset) {
+		case 10: /* RGB 555 */
 			((u32 *)(p->pseudo_palette))[regno] =
 				((red & 0xf8) << 7) |
 				((green & 0xf8) << 2) |
 				((blue & 0xf8) >> 3);
-		}
-		break;
-	case 16:
-		if (regno < 16) {
+			break;
+		case 11: /* RGB 565 */
 			((u32 *)(p->pseudo_palette))[regno] =
 				((red & 0xf8) << 8) |
 				((green & 0xfc) << 3) |
 				((blue & 0xf8) >> 3);
-		}
-		break;
-	case 24:
-		if (regno < 24) {
+			break;
+		case 16: /* RGB 888 */
 			((u32 *)(p->pseudo_palette))[regno] =
 				(red << 16)  |
 				(green << 8) |
 				(blue);
+			break;
 		}
-		break;
 	}
+
 	return 0;
 }
 



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
