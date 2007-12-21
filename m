From: akpm@linux-foundation.org
Subject: [patch 1/1] neofb: avoid overwriting fb_info
	fields
Date: Fri, 21 Dec 2007 15:46:37 -0800
Message-ID: <200712212346.lBLNkc2h005152@imap1.linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J5rZw-0005pz-OG for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 21 Dec 2007 15:46:56 -0800
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J5rZw-0002tV-D1
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 21 Dec 2007 15:46:56 -0800
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: adaplas@pol.net, akpm@linux-foundation.org, marciobuss@gmail.com, ctrefzer@gmx.de

From: Andrew Morton <akpm@linux-foundation.org>

Fix bug identified by Marcio Buss in
http://bugzilla.kernel.org/show_bug.cgi?id=9565 - neofb can overwrite a field
in the fb_info struct.

This fix will result in truncated device identification strings - perhaps
fb_innfo.fix.id can be made larger?

Cc: Marcio Buss <marciobuss@gmail.com>
Cc: "Antonino A. Daplas" <adaplas@pol.net>
Cc: Christian Trefzer <ctrefzer@gmx.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/video/neofb.c |   27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff -puN drivers/video/neofb.c~neofb-avoid-overwriting-fb_info-fields drivers/video/neofb.c
--- a/drivers/video/neofb.c~neofb-avoid-overwriting-fb_info-fields
+++ a/drivers/video/neofb.c
@@ -2066,40 +2066,49 @@ static struct fb_info *__devinit neo_all
 
 	switch (info->fix.accel) {
 	case FB_ACCEL_NEOMAGIC_NM2070:
-		sprintf(info->fix.id, "MagicGraph 128");
+		snprintf(info->fix.id, sizeof(info->fix.id),
+				"MagicGraph 128");
 		break;
 	case FB_ACCEL_NEOMAGIC_NM2090:
-		sprintf(info->fix.id, "MagicGraph 128V");
+		snprintf(info->fix.id, sizeof(info->fix.id),
+				"MagicGraph 128V");
 		break;
 	case FB_ACCEL_NEOMAGIC_NM2093:
-		sprintf(info->fix.id, "MagicGraph 128ZV");
+		snprintf(info->fix.id, sizeof(info->fix.id),
+				"MagicGraph 128ZV");
 		break;
 	case FB_ACCEL_NEOMAGIC_NM2097:
-		sprintf(info->fix.id, "MagicGraph 128ZV+");
+		snprintf(info->fix.id, sizeof(info->fix.id),
+				"MagicGraph 128ZV+");
 		break;
 	case FB_ACCEL_NEOMAGIC_NM2160:
-		sprintf(info->fix.id, "MagicGraph 128XD");
+		snprintf(info->fix.id, sizeof(info->fix.id),
+				"MagicGraph 128XD");
 		break;
 	case FB_ACCEL_NEOMAGIC_NM2200:
-		sprintf(info->fix.id, "MagicGraph 256AV");
+		snprintf(info->fix.id, sizeof(info->fix.id),
+				"MagicGraph 256AV");
 		info->flags |= FBINFO_HWACCEL_IMAGEBLIT |
 		               FBINFO_HWACCEL_COPYAREA |
                 	       FBINFO_HWACCEL_FILLRECT;
 		break;
 	case FB_ACCEL_NEOMAGIC_NM2230:
-		sprintf(info->fix.id, "MagicGraph 256AV+");
+		snprintf(info->fix.id, sizeof(info->fix.id),
+				"MagicGraph 256AV+");
 		info->flags |= FBINFO_HWACCEL_IMAGEBLIT |
 		               FBINFO_HWACCEL_COPYAREA |
                 	       FBINFO_HWACCEL_FILLRECT;
 		break;
 	case FB_ACCEL_NEOMAGIC_NM2360:
-		sprintf(info->fix.id, "MagicGraph 256ZX");
+		snprintf(info->fix.id, sizeof(info->fix.id),
+				"MagicGraph 256ZX");
 		info->flags |= FBINFO_HWACCEL_IMAGEBLIT |
 		               FBINFO_HWACCEL_COPYAREA |
                 	       FBINFO_HWACCEL_FILLRECT;
 		break;
 	case FB_ACCEL_NEOMAGIC_NM2380:
-		sprintf(info->fix.id, "MagicGraph 256XL+");
+		snprintf(info->fix.id, sizeof(info->fix.id),
+				"MagicGraph 256XL+");
 		info->flags |= FBINFO_HWACCEL_IMAGEBLIT |
 		               FBINFO_HWACCEL_COPYAREA |
                 	       FBINFO_HWACCEL_FILLRECT;
_

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
