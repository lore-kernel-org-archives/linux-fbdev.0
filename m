From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 1/11] fbdev: Cleanup broken edid fixup code
Date: Fri, 14 Jan 2005 05:41:54 +0800
Message-ID: <20050113214610.D1A051A0175@smtp-1.hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CpCnd-000141-9M
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 Jan 2005 13:46:37 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CpCnb-0008Vf-3T
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 Jan 2005 13:46:36 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 56A301340CE8
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 13 Jan 2005 21:46:15 +0000 (UTC)
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

Check first if EDID block came from a broken display before fixing.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 fbmon.c |   69 ++++++++++++++++++++++++++++++++++++++++++----------------------
 1 files changed, 46 insertions(+), 23 deletions(-)

diff -Nru a/drivers/video/fbmon.c b/drivers/video/fbmon.c
--- a/drivers/video/fbmon.c	2005-01-13 20:21:47 +08:00
+++ b/drivers/video/fbmon.c	2005-01-13 20:21:47 +08:00
@@ -89,11 +89,12 @@
   while (i-- && (*--s == 0x20)) *s = 0;
 }
 
-static void fix_edid(unsigned char *edid)
+static int check_edid(unsigned char *edid)
 {
 	unsigned char *block = edid + ID_MANUFACTURER_NAME, manufacturer[4];
 	unsigned char *b;
-	u32 model, i;
+	u32 model;
+	int i, fix = 0, ret = 0;
 
 	manufacturer[0] = ((block[0] & 0x7c) >> 2) + '@';
 	manufacturer[1] = ((block[0] & 0x03) << 3) +
@@ -105,36 +106,57 @@
 	for (i = 0; i < ARRAY_SIZE(brokendb); i++) {
 		if (!strncmp(manufacturer, brokendb[i].manufacturer, 4) &&
 			brokendb[i].model == model) {
-
 			printk("fbmon: The EDID Block of "
 			       "Manufacturer: %s Model: 0x%x is known to "
 			       "be broken,\n",  manufacturer, model);
-			switch (brokendb[i].fix) {
-			case FBMON_FIX_HEADER:
-				printk("fbmon: trying a header "
-				       "reconstruct\n");
-				memcpy(edid, edid_v1_header, 8);
-				break;
-			case FBMON_FIX_INPUT:
-				printk("fbmon: trying to fix input type\n");
-				b = edid + EDID_STRUCT_DISPLAY;
-				/* Only if display is GTF capable will
-				   the input type be reset to analog */
-				if (b[4] & 0x01) {
-					b[0] &= ~0x80;
-					edid[127] += 0x80;
-				}
-			}
+ 			fix = brokendb[i].fix;
+ 			break;
 		}
 	}
+
+	switch (fix) {
+	case FBMON_FIX_HEADER:
+		for (i = 0; i < 8; i++) {
+			if (edid[i] != edid_v1_header[i])
+				ret = fix;
+		}
+		break;
+	case FBMON_FIX_INPUT:
+		b = edid + EDID_STRUCT_DISPLAY;
+		/* Only if display is GTF capable will
+		   the input type be reset to analog */
+		if (b[4] & 0x01 && b[0] & 0x80)
+			ret = fix;
+		break;
+	}
+
+	return ret;
+}
+ 
+static void fix_edid(unsigned char *edid, int fix)
+{
+	unsigned char *b;
+
+	switch (fix) {
+	case FBMON_FIX_HEADER:
+		printk("fbmon: trying a header reconstruct\n");
+		memcpy(edid, edid_v1_header, 8);
+		break;
+	case FBMON_FIX_INPUT:
+		printk("fbmon: trying to fix input type\n");
+		b = edid + EDID_STRUCT_DISPLAY;
+		b[0] &= ~0x80;
+		edid[127] += 0x80;
+	}
 }
 
 static int edid_checksum(unsigned char *edid)
 {
 	unsigned char i, csum = 0, all_null = 0;
-	int err = 0;
+	int err = 0, fix = check_edid(edid);
 
-	fix_edid(edid);
+	if (fix)
+		fix_edid(edid, fix);
 
 	for (i = 0; i < EDID_LENGTH; i++) {
 		csum += edid[i];
@@ -151,9 +173,10 @@
 
 static int edid_check_header(unsigned char *edid)
 {
-	int i, err = 1;
+	int i, err = 1, fix = check_edid(edid);
 
-	fix_edid(edid);
+	if (fix)
+		fix_edid(edid, fix);
 
 	for (i = 0; i < 8; i++) {
 		if (edid[i] != edid_v1_header[i])




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
