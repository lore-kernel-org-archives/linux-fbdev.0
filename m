From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 7/9] fbdev: Add Viewsonic PF775a to broken display database
Date: Tue, 21 Dec 2004 23:34:15 +0800
Message-ID: <20041221213707.A8C771A0239@smtp-1.hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CgrhB-0007oX-MF
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 21 Dec 2004 13:37:29 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CgrhA-0001Kn-CZ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 21 Dec 2004 13:37:29 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 476F0C14B36
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 21 Dec 2004 21:37:15 +0000 (UTC)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Add Viewsonic PF775a to broken display database

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 fbmon.c |   67 +++++++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 37 insertions(+), 30 deletions(-)

diff -Nru a/drivers/video/fbmon.c b/drivers/video/fbmon.c
--- a/drivers/video/fbmon.c	2004-10-19 20:21:41 +08:00
+++ b/drivers/video/fbmon.c	2004-12-14 05:46:20 +08:00
@@ -50,6 +50,7 @@
 #endif
 
 #define FBMON_FIX_HEADER 1
+#define FBMON_FIX_INPUT  2
 
 #ifdef CONFIG_FB_MODE_HELPERS
 struct broken_edid {
@@ -60,9 +61,16 @@
 
 static struct broken_edid brokendb[] = {
 	/* DEC FR-PCXAV-YZ */
-	{ .manufacturer = "DEC",
-	  .model        = 0x073a,
-	  .fix          = FBMON_FIX_HEADER,
+	{
+		.manufacturer = "DEC",
+		.model        = 0x073a,
+		.fix          = FBMON_FIX_HEADER,
+	},
+	/* ViewSonic PF775a */
+	{
+		.manufacturer = "VSC",
+		.model        = 0x5a44,
+		.fix          = FBMON_FIX_INPUT,
 	},
 };
 
@@ -81,9 +89,10 @@
   while (i-- && (*--s == 0x20)) *s = 0;
 }
 
-static void fix_broken_edid(unsigned char *edid)
+static void fix_edid(unsigned char *edid)
 {
 	unsigned char *block = edid + ID_MANUFACTURER_NAME, manufacturer[4];
+	unsigned char *b;
 	u32 model, i;
 
 	manufacturer[0] = ((block[0] & 0x7c) >> 2) + '@';
@@ -96,15 +105,25 @@
 	for (i = 0; i < ARRAY_SIZE(brokendb); i++) {
 		if (!strncmp(manufacturer, brokendb[i].manufacturer, 4) &&
 			brokendb[i].model == model) {
+
+			printk("fbmon: The EDID Block of "
+			       "Manufacturer: %s Model: 0x%x is known to "
+			       "be broken,\n",  manufacturer, model);
 			switch (brokendb[i].fix) {
 			case FBMON_FIX_HEADER:
-				printk("fbmon: The EDID header of "
-				       "Manufacturer: %s Model: 0x%x is "
-				       "known to be broken,\n"
-				       "fbmon: trying a header "
-				       "reconstruct\n", manufacturer, model);
+				printk("fbmon: trying a header "
+				       "reconstruct\n");
 				memcpy(edid, edid_v1_header, 8);
 				break;
+			case FBMON_FIX_INPUT:
+				printk("fbmon: trying to fix input type\n");
+				b = edid + EDID_STRUCT_DISPLAY;
+				/* Only if display is GTF capable will
+				   the input type be reset to analog */
+				if (b[4] & 0x01) {
+					b[0] &= ~0x80;
+					edid[127] += 0x80;
+				}
 			}
 		}
 	}
@@ -113,6 +132,9 @@
 static int edid_checksum(unsigned char *edid)
 {
 	unsigned char i, csum = 0, all_null = 0;
+	int err = 0;
+
+	fix_edid(edid);
 
 	for (i = 0; i < EDID_LENGTH; i++) {
 		csum += edid[i];
@@ -121,38 +143,23 @@
 
 	if (csum == 0x00 && all_null) {
 		/* checksum passed, everything's good */
-		return 1;
+		err = 1;
 	}
 
-	fix_broken_edid(edid);
-	csum = all_null = 0;
-	for (i = 0; i < EDID_LENGTH; i++) {
-		csum += edid[i];
-		all_null |= edid[i];
-	}
-	if (csum != 0x00 || !all_null) {
-		printk("EDID checksum failed, aborting\n");
-		return 0;
-	}
-	return 1;
+	return err;
 }
 
 static int edid_check_header(unsigned char *edid)
 {
-	int i, fix = 0;
+	int i, err = 1;
 
-	for (i = 0; i < 8; i++) {
-		if (edid[i] != edid_v1_header[i])
-			fix = 1;
-	}
-	if (!fix)
-		return 1;
+	fix_edid(edid);
 
-	fix_broken_edid(edid);
 	for (i = 0; i < 8; i++) {
 		if (edid[i] != edid_v1_header[i])
-			return 0;
+			err = 0;
 	}
+
 	return 1;
 }
 




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
