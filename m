From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 13/18] intelfb: Fix buffer overrun
Date: Sat, 11 Mar 2006 09:51:13 +0800
Message-ID: <44122D11.8090404@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FHtlh-0004vd-3A
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Mar 2006 18:23:45 -0800
Received: from pproxy.gmail.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FHtNt-0003lQ-7R
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Mar 2006 17:59:10 -0800
Received: by pproxy.gmail.com with SMTP id z59so419612pyg
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Mar 2006 17:59:06 -0800 (PST)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Sylvain Meyer <sylvain.meyer@worldonline.fr>

The pseudo_palette has room only for 16 entries, but intelfb_setcolreg
will attempt to write more.

Coverity Bug 558

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/intelfb/intelfbdrv.c |   50 +++++++++++++++++++-----------------
 1 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/intelfbdrv.c
index 6b8bd3c..995b47c 100644
--- a/drivers/video/intelfb/intelfbdrv.c
+++ b/drivers/video/intelfb/intelfbdrv.c
@@ -1333,33 +1333,35 @@ intelfb_setcolreg(unsigned regno, unsign
 	if (regno > 255)
 		return 1;
 
-	switch (dinfo->depth) {
-	case 8:
-		{
-			red >>= 8;
-			green >>= 8;
-			blue >>= 8;
+	if (dinfo->depth == 8) {
+		red >>= 8;
+		green >>= 8;
+		blue >>= 8;
 
-			intelfbhw_setcolreg(dinfo, regno, red, green, blue,
-					    transp);
+		intelfbhw_setcolreg(dinfo, regno, red, green, blue,
+				    transp);
+	}
+
+	if (regno < 16) {
+		switch (dinfo->depth) {
+		case 15:
+			dinfo->pseudo_palette[regno] = ((red & 0xf800) >>  1) |
+				((green & 0xf800) >>  6) |
+				((blue & 0xf800) >> 11);
+			break;
+		case 16:
+			dinfo->pseudo_palette[regno] = (red & 0xf800) |
+				((green & 0xfc00) >>  5) |
+				((blue  & 0xf800) >> 11);
+			break;
+		case 24:
+			dinfo->pseudo_palette[regno] = ((red & 0xff00) << 8) |
+				(green & 0xff00) |
+				((blue  & 0xff00) >> 8);
+			break;
 		}
-		break;
-	case 15:
-		dinfo->pseudo_palette[regno] = ((red & 0xf800) >>  1) |
-					       ((green & 0xf800) >>  6) |
-					       ((blue & 0xf800) >> 11);
-		break;
-	case 16:
-		dinfo->pseudo_palette[regno] = (red & 0xf800) |
-					       ((green & 0xfc00) >>  5) |
-					       ((blue  & 0xf800) >> 11);
-		break;
-	case 24:
-		dinfo->pseudo_palette[regno] = ((red & 0xff00) << 8) |
-					       (green & 0xff00) |
-					       ((blue  & 0xff00) >> 8);
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
