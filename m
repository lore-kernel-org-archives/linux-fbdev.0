From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: [PATCH] GeForce 5200 on rivafb
Date: Tue, 14 Dec 2004 04:52:18 +0800
Message-ID: <200412140452.19873.adaplas@hotpop.com>
References: <200412120511.31725.adaplas@hotpop.com> <7vd5xgmevm.fsf@assigned-by-dhcp.cox.net> <7vpt1fu97r.fsf@assigned-by-dhcp.cox.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CdxCV-0000z8-Df
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 13 Dec 2004 12:53:47 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CdxCU-0001Ws-G1
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 13 Dec 2004 12:53:47 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 16792B0C649
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 13 Dec 2004 20:53:34 +0000 (UTC)
In-Reply-To: <7vpt1fu97r.fsf@assigned-by-dhcp.cox.net>
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
To: Junio C Hamano <junkio@cox.net>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Sunday 12 December 2004 18:00, Junio C Hamano wrote:
> >>>>> "AAD" == Antonino A Daplas <adaplas@hotpop.com> writes:
>
> AAD> 1. Change this line in drivers/video/fbmon.c
>
> AAD> #undef DEBUG
> AAD> to
> AAD> #define DEBUG
>
> >>> Will do, but I have one question.  The last time I tried
> >>> turning debugging on on rivafb-i2c it was very unpleasant;
>
> AAD> No :-), this is not for nvidiafb but for the EDID parser, and it will
> give AAD> you a very descriptive parsing of the EDID block.
>
> The attached is what I got in the kernel boot log.  Again,
> AFAICT the display is an analog CRT but one of the decoded lines
> say "Digital Display Input".  Anyway I'll disable the i2c stuff
> in the meantime as you recommended.
>

Can you try this patch and enable nvidiafb-i2c. It adds your monitor model
to the database of displays with broken edid's and attempts a fix. It checks
first if the monitor is GTF capable, and if it is, sets the input type from
digital to analog. (I don't think digital inputs can be GTF capable).

However, do you know if your monitor model does support digital input?

Tony

diff -Nru a/drivers/video/fbmon.c b/drivers/video/fbmon.c
--- a/drivers/video/fbmon.c	2004-11-21 22:32:56 +08:00
+++ b/drivers/video/fbmon.c	2004-12-14 04:38:30 +08:00
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
 
@@ -80,9 +88,10 @@
   while (i-- && (*--s == 0x20)) *s = 0;
 }
 
-static void fix_broken_edid(unsigned char *edid)
+static void fix_edid(unsigned char *edid)
 {
 	unsigned char *block = edid + ID_MANUFACTURER_NAME, manufacturer[4];
+	unsigned char *b;
 	u32 model, i;
 
 	manufacturer[0] = ((block[0] & 0x7c) >> 2) + '@';
@@ -95,15 +104,23 @@
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
+				if (b[4] & 0x01)
+					b[0] &= ~0x80;
 			}
 		}
 	}
@@ -112,6 +129,9 @@
 static int edid_checksum(unsigned char *edid)
 {
 	unsigned char i, csum = 0, all_null = 0;
+	int err = 0;
+
+	fix_edid(edid);
 
 	for (i = 0; i < EDID_LENGTH; i++) {
 		csum += edid[i];
@@ -120,38 +140,23 @@
 
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
