From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: PATCH: fixup EDID for slightly broken monitors
Date: Tue, 27 Jul 2004 10:18:38 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200407271012.00418.adaplas@hotpop.com>
References: <Pine.LNX.4.21.0407151711290.1024-100000@tull.umassp.edu> <20040726152555.30271a6b.akpm@osdl.org>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BpHYl-0003oK-6L
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 26 Jul 2004 19:19:20 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BpHYk-0006Lb-Jn
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 26 Jul 2004 19:19:19 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id D9E2C6FBD76
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 27 Jul 2004 01:29:28 +0000 (UTC)
In-Reply-To: <20040726152555.30271a6b.akpm@osdl.org>
Content-Disposition: inline
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
To: Andrew Morton <akpm@osdl.org>, "Brian S. Julin" <bri@tull.umassp.edu>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Tuesday 27 July 2004 06:25, Andrew Morton wrote:
> Could the fbdev people please review this?
>
> Brian, in future, kernel patches should be in `patch -p1' form.  And your
> mailer replaces tabs with spaces.  And your signature gives `patch' a heart
> attack.  And we always place the body of a `for' loop on a separate line.
>
> Thanks.
>

Instead of blindly doing a header reconstruct, why not check against a known
database of broken displays?

One of the plans was to do that, so this is a good time to start as any. If 
in the future the database becomes too heavy, we can always config this out.  

Brian, I used "DEC" for the manufacturer string, and 0x073a for the model id.
Is this correct?

Tony

1. Created a database of broken displays and their associated fixes. 
Original patch from Brian S. Julin <bri@tull.umassp.edu>.  Only the
monitor manufacturer and model is checked, perhaps we can also check
for the serial number?

2. Added an all_null check in edid_checksum since the checksum will also be 
zero if the entire block is zeroed.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
diff -uprN linux-2.6.8-rc1-mm1-orig/drivers/video/fbmon.c linux-2.6.8-rc1-mm1/drivers/video/fbmon.c
--- linux-2.6.8-rc1-mm1-orig/drivers/video/fbmon.c	2004-07-27 01:43:36.000000000 +0000
+++ linux-2.6.8-rc1-mm1/drivers/video/fbmon.c	2004-07-27 02:04:55.477448456 +0000
@@ -49,6 +49,21 @@
 #define DPRINTK(fmt, args...)
 #endif
 
+#define FBMON_FIX_HEADER 1
+
+struct broken_edid {
+	u8  manufacturer[4];
+	u32 model;
+	u32 fix;
+};
+
+static struct broken_edid brokendb[] = {
+	/* DEC FR-PCXAV-YZ */
+	{ .manufacturer = "DEC",
+	  .model        = 0x073a,
+	  .fix          = FBMON_FIX_HEADER,
+	},
+};
 
 const unsigned char edid_v1_header[] = { 0x00, 0xff, 0xff, 0xff,
 	0xff, 0xff, 0xff, 0x00
@@ -65,30 +80,77 @@ static void copy_string(unsigned char *c
   while (i-- && (*--s == 0x20)) *s = 0;
 }
 
-static int edid_checksum(unsigned char *edid)
+static void fix_broken_edid(unsigned char *edid)
 {
-	unsigned char i, csum = 0;
+	unsigned char *block = edid + ID_MANUFACTURER_NAME, manufacturer[4];
+	u32 model, i;
+
+	manufacturer[0] = ((block[0] & 0x7c) >> 2) + '@';
+	manufacturer[1] = ((block[0] & 0x03) << 3) +
+		((block[1] & 0xe0) >> 5) + '@';
+	manufacturer[2] = (block[1] & 0x1f) + '@';
+	manufacturer[3] = 0;
+	model = block[2] + (block[3] << 8);
+	
+	for (i = 0; i < ARRAY_SIZE(brokendb); i++) {
+		if (!strncmp(manufacturer, brokendb[i].manufacturer, 4) &&
+			brokendb[i].model == model) {
+			switch (brokendb[i].fix) {
+			case FBMON_FIX_HEADER:
+				printk("fbmon: The EDID header of "
+				       "Manufacturer: %s Model: 0x%x is "
+				       "known to be broken,\n"
+				       "fbmon: trying a header "
+				       "reconstruct\n", manufacturer, model);
+				memcpy(edid, edid_v1_header, 8);
+				break;
+			}
+		}
+	}
+}
 
-	for (i = 0; i < EDID_LENGTH; i++)
+static int edid_checksum(unsigned char *edid)
+{
+	unsigned char i, csum = 0, all_null = 0;
+	
+	for (i = 0; i < EDID_LENGTH; i++) {
 		csum += edid[i];
+		all_null |= edid[i];
+	}
 
-	if (csum == 0x00) {
+	if (csum == 0x00 && all_null) {
 		/* checksum passed, everything's good */
 		return 1;
-	} else {
+	}
+
+	fix_broken_edid(edid);
+	csum = all_null = 0;
+	for (i = 0; i < EDID_LENGTH; i++) {
+		csum += edid[i];
+		all_null |= edid[i];
+	}
+	if (csum != 0x00 || !all_null) {
 		printk("EDID checksum failed, aborting\n");
 		return 0;
 	}
+	return 1;
 }
 
 static int edid_check_header(unsigned char *edid)
 {
-	if ((edid[0] != 0x00) || (edid[1] != 0xff) || (edid[2] != 0xff) ||
-	    (edid[3] != 0xff) || (edid[4] != 0xff) || (edid[5] != 0xff) ||
-	    (edid[6] != 0xff)) {
-		printk
-		    ("EDID header doesn't match EDID v1 header, aborting\n");
-		return 0;
+	int i, fix = 0;
+
+	for (i = 0; i < 8; i++) {
+		if (edid[i] != edid_v1_header[i])
+			fix = 1;
+	}
+	if (!fix) 
+		return 1;
+
+	fix_broken_edid(edid);
+	for (i = 0; i < 8; i++) {
+		if (edid[i] != edid_v1_header[i])
+			return 0;
 	}
 	return 1;
 }




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
