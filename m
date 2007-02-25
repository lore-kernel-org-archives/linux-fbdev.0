From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/9] fbdev: Add Ultrasharp UXGA to
	broken monitor database
Date: Sun, 25 Feb 2007 16:48:49 +0800
Message-ID: <1172393329.16179.27.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1049773165=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HLFPA-00075k-Fl for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Feb 2007 01:10:52 -0800
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HLFP9-0005hh-Mn
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Feb 2007 01:10:52 -0800
Received: by py-out-1112.google.com with SMTP id a29so528629pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Feb 2007 01:10:51 -0800 (PST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


--===============1049773165==
Content-Type: multipart/alternative; boundary="=-T8ULzMjVhreFyn2N3t7Q"


--=-T8ULzMjVhreFyn2N3t7Q
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This particular monitor does not have a limits block and has only one set of
monitor timings. Fix by adding a limits block to the EDID and extend the
horizontal sync frequency range to 30 kHz and 75 Khz.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/fbmon.c |  168 +++++++++++++++++++++++++++++++++----------------
 1 files changed, 112 insertions(+), 56 deletions(-)

diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index 6b385c3..05a9464 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -48,8 +48,9 @@ #else
 #define DPRINTK(fmt, args...)
 #endif
 
-#define FBMON_FIX_HEADER 1
-#define FBMON_FIX_INPUT  2
+#define FBMON_FIX_HEADER  1
+#define FBMON_FIX_INPUT   2
+#define FBMON_FIX_TIMINGS 3
 
 #ifdef CONFIG_FB_MODE_HELPERS
 struct broken_edid {
@@ -71,6 +72,12 @@ static const struct broken_edid brokendb
 		.model        = 0x5a44,
 		.fix          = FBMON_FIX_INPUT,
 	},
+	/* Sharp UXGA? */
+	{
+		.manufacturer = "SHP",
+		.model        = 0x138e,
+		.fix          = FBMON_FIX_TIMINGS,
+	},
 };
 
 static const unsigned char edid_v1_header[] = { 0x00, 0xff, 0xff, 0xff,
@@ -87,6 +94,55 @@ static void copy_string(unsigned char *c
   while (i-- && (*--s == 0x20)) *s = 0;
 }
 
+static int edid_is_serial_block(unsigned char *block)
+{
+	if ((block[0] == 0x00) && (block[1] == 0x00) &&
+	    (block[2] == 0x00) && (block[3] == 0xff) &&
+	    (block[4] == 0x00))
+		return 1;
+	else
+		return 0;
+}
+
+static int edid_is_ascii_block(unsigned char *block)
+{
+	if ((block[0] == 0x00) && (block[1] == 0x00) &&
+	    (block[2] == 0x00) && (block[3] == 0xfe) &&
+	    (block[4] == 0x00))
+		return 1;
+	else
+		return 0;
+}
+
+static int edid_is_limits_block(unsigned char *block)
+{
+	if ((block[0] == 0x00) && (block[1] == 0x00) &&
+	    (block[2] == 0x00) && (block[3] == 0xfd) &&
+	    (block[4] == 0x00))
+		return 1;
+	else
+		return 0;
+}
+
+static int edid_is_monitor_block(unsigned char *block)
+{
+	if ((block[0] == 0x00) && (block[1] == 0x00) &&
+	    (block[2] == 0x00) && (block[3] == 0xfc) &&
+	    (block[4] == 0x00))
+		return 1;
+	else
+		return 0;
+}
+
+static int edid_is_timing_block(unsigned char *block)
+{
+	if ((block[0] != 0x00) || (block[1] != 0x00) ||
+	    (block[2] != 0x00) || (block[4] != 0x00))
+		return 1;
+	else
+		return 0;
+}
+
 static int check_edid(unsigned char *edid)
 {
 	unsigned char *block = edid + ID_MANUFACTURER_NAME, manufacturer[4];
@@ -104,9 +160,6 @@ static int check_edid(unsigned char *edi
 	for (i = 0; i < ARRAY_SIZE(brokendb); i++) {
 		if (!strncmp(manufacturer, brokendb[i].manufacturer, 4) &&
 			brokendb[i].model == model) {
-			printk("fbmon: The EDID Block of "
-			       "Manufacturer: %s Model: 0x%x is known to "
-			       "be broken,\n",  manufacturer, model);
  			fix = brokendb[i].fix;
  			break;
 		}
@@ -115,8 +168,10 @@ static int check_edid(unsigned char *edi
 	switch (fix) {
 	case FBMON_FIX_HEADER:
 		for (i = 0; i < 8; i++) {
-			if (edid[i] != edid_v1_header[i])
+			if (edid[i] != edid_v1_header[i]) {
 				ret = fix;
+				break;
+			}
 		}
 		break;
 	case FBMON_FIX_INPUT:
@@ -126,14 +181,33 @@ static int check_edid(unsigned char *edi
 		if (b[4] & 0x01 && b[0] & 0x80)
 			ret = fix;
 		break;
+	case FBMON_FIX_TIMINGS:
+		b = edid + DETAILED_TIMING_DESCRIPTIONS_START;
+
+		for (i = 0; i < 4; i++) {
+			if (edid_is_limits_block(b)) {
+				ret = fix;
+				break;
+			}
+
+			b += DETAILED_TIMING_DESCRIPTION_SIZE;
+		}
+
+		break;
 	}
 
+	if (ret)
+		printk("fbmon: The EDID Block of "
+		       "Manufacturer: %s Model: 0x%x is known to "
+		       "be broken,\n",  manufacturer, model);
+
 	return ret;
 }
 
 static void fix_edid(unsigned char *edid, int fix)
 {
-	unsigned char *b;
+	int i;
+	unsigned char *b, csum = 0;
 
 	switch (fix) {
 	case FBMON_FIX_HEADER:
@@ -145,6 +219,37 @@ static void fix_edid(unsigned char *edid
 		b = edid + EDID_STRUCT_DISPLAY;
 		b[0] &= ~0x80;
 		edid[127] += 0x80;
+		break;
+	case FBMON_FIX_TIMINGS:
+		printk("fbmon: trying to fix monitor timings\n");
+		b = edid + DETAILED_TIMING_DESCRIPTIONS_START;
+		for (i = 0; i < 4; i++) {
+			if (!(edid_is_serial_block(b) ||
+			      edid_is_ascii_block(b) ||
+			      edid_is_monitor_block(b) ||
+			      edid_is_timing_block(b))) {
+				b[0] = 0x00;
+				b[1] = 0x00;
+				b[2] = 0x00;
+				b[3] = 0xfd;
+				b[4] = 0x00;
+				b[5] = 60;   /* vfmin */
+				b[6] = 60;   /* vfmax */
+				b[7] = 30;   /* hfmin */
+				b[8] = 75;   /* hfmax */
+				b[9] = 17;   /* pixclock - 170 MHz*/
+				b[10] = 0;   /* GTF */
+				break;
+			}
+
+			b += DETAILED_TIMING_DESCRIPTION_SIZE;
+		}
+
+		for (i = 0; i < EDID_LENGTH - 1; i++)
+			csum += edid[i];
+
+		edid[127] = 256 - csum;
+		break;
 	}
 }
 
@@ -273,46 +378,6 @@ static void get_chroma(unsigned char *bl
 	DPRINTK("WhiteY:   0.%03d\n", specs->chroma.whitey);
 }
 
-static int edid_is_serial_block(unsigned char *block)
-{
-	if ((block[0] == 0x00) && (block[1] == 0x00) && 
-	    (block[2] == 0x00) && (block[3] == 0xff) &&
-	    (block[4] == 0x00))
-		return 1;
-	else
-		return 0;
-}
-
-static int edid_is_ascii_block(unsigned char *block)
-{
-	if ((block[0] == 0x00) && (block[1] == 0x00) && 
-	    (block[2] == 0x00) && (block[3] == 0xfe) &&
-	    (block[4] == 0x00))
-		return 1;
-	else
-		return 0;
-}
-
-static int edid_is_limits_block(unsigned char *block)
-{
-	if ((block[0] == 0x00) && (block[1] == 0x00) && 
-	    (block[2] == 0x00) && (block[3] == 0xfd) &&
-	    (block[4] == 0x00))
-		return 1;
-	else
-		return 0;
-}
-
-static int edid_is_monitor_block(unsigned char *block)
-{
-	if ((block[0] == 0x00) && (block[1] == 0x00) && 
-	    (block[2] == 0x00) && (block[3] == 0xfc) &&
-	    (block[4] == 0x00))
-		return 1;
-	else
-		return 0;
-}
-
 static void calc_mode_timings(int xres, int yres, int refresh,
 			      struct fb_videomode *mode)
 {
@@ -795,15 +860,6 @@ static void get_monspecs(unsigned char *
 	}
 }
 
-static int edid_is_timing_block(unsigned char *block)
-{
-	if ((block[0] != 0x00) || (block[1] != 0x00) ||
-	    (block[2] != 0x00) || (block[4] != 0x00))
-		return 1;
-	else
-		return 0;
-}
-
 int fb_parse_edid(unsigned char *edid, struct fb_var_screeninfo *var)
 {
 	int i;


--=-T8ULzMjVhreFyn2N3t7Q
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.2">
</HEAD>
<BODY>
<PRE>
<!--+GtkHTML:<DATA class="ClueFlow" key="orig" value="0">-->This particular monitor does not have a limits block and has only one set of
monitor timings. Fix by adding a limits block to the EDID and extend the
horizontal sync frequency range to 30 kHz and 75 Khz.

Signed-off-by: Antonino Daplas &lt;<A HREF="mailto:adaplas@gmail.com">adaplas@gmail.com</A>&gt;
---

 drivers/video/fbmon.c |&nbsp; 168 +++++++++++++++++++++++++++++++++----------------
 1 files changed, 112 insertions(+), 56 deletions(-)

diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index 6b385c3..05a9464 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -48,8 +48,9 @@ #else
 #define DPRINTK(fmt, args...)
 #endif
 
-#define FBMON_FIX_HEADER 1
-#define FBMON_FIX_INPUT&nbsp; 2
+#define FBMON_FIX_HEADER&nbsp; 1
+#define FBMON_FIX_INPUT&nbsp;&nbsp; 2
+#define FBMON_FIX_TIMINGS 3
 
 #ifdef CONFIG_FB_MODE_HELPERS
 struct broken_edid {
@@ -71,6 +72,12 @@ static const struct broken_edid brokendb
 		.model&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0x5a44,
 		.fix&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = FBMON_FIX_INPUT,
 	},
+	/* Sharp UXGA? */
+	{
+		.manufacturer = &quot;SHP&quot;,
+		.model&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0x138e,
+		.fix&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = FBMON_FIX_TIMINGS,
+	},
 };
 
 static const unsigned char edid_v1_header[] = { 0x00, 0xff, 0xff, 0xff,
@@ -87,6 +94,55 @@ static void copy_string(unsigned char *c
&nbsp;&nbsp; while (i-- &amp;&amp; (*--s == 0x20)) *s = 0;
 }
 
+static int edid_is_serial_block(unsigned char *block)
+{
+	if ((block[0] == 0x00) &amp;&amp; (block[1] == 0x00) &amp;&amp;
+	&nbsp;&nbsp;&nbsp; (block[2] == 0x00) &amp;&amp; (block[3] == 0xff) &amp;&amp;
+	&nbsp;&nbsp;&nbsp; (block[4] == 0x00))
+		return 1;
+	else
+		return 0;
+}
+
+static int edid_is_ascii_block(unsigned char *block)
+{
+	if ((block[0] == 0x00) &amp;&amp; (block[1] == 0x00) &amp;&amp;
+	&nbsp;&nbsp;&nbsp; (block[2] == 0x00) &amp;&amp; (block[3] == 0xfe) &amp;&amp;
+	&nbsp;&nbsp;&nbsp; (block[4] == 0x00))
+		return 1;
+	else
+		return 0;
+}
+
+static int edid_is_limits_block(unsigned char *block)
+{
+	if ((block[0] == 0x00) &amp;&amp; (block[1] == 0x00) &amp;&amp;
+	&nbsp;&nbsp;&nbsp; (block[2] == 0x00) &amp;&amp; (block[3] == 0xfd) &amp;&amp;
+	&nbsp;&nbsp;&nbsp; (block[4] == 0x00))
+		return 1;
+	else
+		return 0;
+}
+
+static int edid_is_monitor_block(unsigned char *block)
+{
+	if ((block[0] == 0x00) &amp;&amp; (block[1] == 0x00) &amp;&amp;
+	&nbsp;&nbsp;&nbsp; (block[2] == 0x00) &amp;&amp; (block[3] == 0xfc) &amp;&amp;
+	&nbsp;&nbsp;&nbsp; (block[4] == 0x00))
+		return 1;
+	else
+		return 0;
+}
+
+static int edid_is_timing_block(unsigned char *block)
+{
+	if ((block[0] != 0x00) || (block[1] != 0x00) ||
+	&nbsp;&nbsp;&nbsp; (block[2] != 0x00) || (block[4] != 0x00))
+		return 1;
+	else
+		return 0;
+}
+
 static int check_edid(unsigned char *edid)
 {
 	unsigned char *block = edid + ID_MANUFACTURER_NAME, manufacturer[4];
@@ -104,9 +160,6 @@ static int check_edid(unsigned char *edi
 	for (i = 0; i &lt; ARRAY_SIZE(brokendb); i++) {
 		if (!strncmp(manufacturer, brokendb[i].manufacturer, 4) &amp;&amp;
 			brokendb[i].model == model) {
-			printk(&quot;fbmon: The EDID Block of &quot;
-			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Manufacturer: %s Model: 0x%x is known to &quot;
-			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;be broken,\n&quot;,&nbsp; manufacturer, model);
&nbsp; 			fix = brokendb[i].fix;
&nbsp; 			break;
 		}
@@ -115,8 +168,10 @@ static int check_edid(unsigned char *edi
 	switch (fix) {
 	case FBMON_FIX_HEADER:
 		for (i = 0; i &lt; 8; i++) {
-			if (edid[i] != edid_v1_header[i])
+			if (edid[i] != edid_v1_header[i]) {
 				ret = fix;
+				break;
+			}
 		}
 		break;
 	case FBMON_FIX_INPUT:
@@ -126,14 +181,33 @@ static int check_edid(unsigned char *edi
 		if (b[4] &amp; 0x01 &amp;&amp; b[0] &amp; 0x80)
 			ret = fix;
 		break;
+	case FBMON_FIX_TIMINGS:
+		b = edid + DETAILED_TIMING_DESCRIPTIONS_START;
+
+		for (i = 0; i &lt; 4; i++) {
+			if (edid_is_limits_block(b)) {
+				ret = fix;
+				break;
+			}
+
+			b += DETAILED_TIMING_DESCRIPTION_SIZE;
+		}
+
+		break;
 	}
 
+	if (ret)
+		printk(&quot;fbmon: The EDID Block of &quot;
+		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Manufacturer: %s Model: 0x%x is known to &quot;
+		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;be broken,\n&quot;,&nbsp; manufacturer, model);
+
 	return ret;
 }
 
 static void fix_edid(unsigned char *edid, int fix)
 {
-	unsigned char *b;
+	int i;
+	unsigned char *b, csum = 0;
 
 	switch (fix) {
 	case FBMON_FIX_HEADER:
@@ -145,6 +219,37 @@ static void fix_edid(unsigned char *edid
 		b = edid + EDID_STRUCT_DISPLAY;
 		b[0] &amp;= ~0x80;
 		edid[127] += 0x80;
+		break;
+	case FBMON_FIX_TIMINGS:
+		printk(&quot;fbmon: trying to fix monitor timings\n&quot;);
+		b = edid + DETAILED_TIMING_DESCRIPTIONS_START;
+		for (i = 0; i &lt; 4; i++) {
+			if (!(edid_is_serial_block(b) ||
+			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; edid_is_ascii_block(b) ||
+			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; edid_is_monitor_block(b) ||
+			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; edid_is_timing_block(b))) {
+				b[0] = 0x00;
+				b[1] = 0x00;
+				b[2] = 0x00;
+				b[3] = 0xfd;
+				b[4] = 0x00;
+				b[5] = 60;&nbsp;&nbsp; /* vfmin */
+				b[6] = 60;&nbsp;&nbsp; /* vfmax */
+				b[7] = 30;&nbsp;&nbsp; /* hfmin */
+				b[8] = 75;&nbsp;&nbsp; /* hfmax */
+				b[9] = 17;&nbsp;&nbsp; /* pixclock - 170 MHz*/
+				b[10] = 0;&nbsp;&nbsp; /* GTF */
+				break;
+			}
+
+			b += DETAILED_TIMING_DESCRIPTION_SIZE;
+		}
+
+		for (i = 0; i &lt; EDID_LENGTH - 1; i++)
+			csum += edid[i];
+
+		edid[127] = 256 - csum;
+		break;
 	}
 }
 
@@ -273,46 +378,6 @@ static void get_chroma(unsigned char *bl
 	DPRINTK(&quot;WhiteY:&nbsp;&nbsp; 0.%03d\n&quot;, specs-&gt;chroma.whitey);
 }
 
-static int edid_is_serial_block(unsigned char *block)
-{
-	if ((block[0] == 0x00) &amp;&amp; (block[1] == 0x00) &amp;&amp; 
-	&nbsp;&nbsp;&nbsp; (block[2] == 0x00) &amp;&amp; (block[3] == 0xff) &amp;&amp;
-	&nbsp;&nbsp;&nbsp; (block[4] == 0x00))
-		return 1;
-	else
-		return 0;
-}
-
-static int edid_is_ascii_block(unsigned char *block)
-{
-	if ((block[0] == 0x00) &amp;&amp; (block[1] == 0x00) &amp;&amp; 
-	&nbsp;&nbsp;&nbsp; (block[2] == 0x00) &amp;&amp; (block[3] == 0xfe) &amp;&amp;
-	&nbsp;&nbsp;&nbsp; (block[4] == 0x00))
-		return 1;
-	else
-		return 0;
-}
-
-static int edid_is_limits_block(unsigned char *block)
-{
-	if ((block[0] == 0x00) &amp;&amp; (block[1] == 0x00) &amp;&amp; 
-	&nbsp;&nbsp;&nbsp; (block[2] == 0x00) &amp;&amp; (block[3] == 0xfd) &amp;&amp;
-	&nbsp;&nbsp;&nbsp; (block[4] == 0x00))
-		return 1;
-	else
-		return 0;
-}
-
-static int edid_is_monitor_block(unsigned char *block)
-{
-	if ((block[0] == 0x00) &amp;&amp; (block[1] == 0x00) &amp;&amp; 
-	&nbsp;&nbsp;&nbsp; (block[2] == 0x00) &amp;&amp; (block[3] == 0xfc) &amp;&amp;
-	&nbsp;&nbsp;&nbsp; (block[4] == 0x00))
-		return 1;
-	else
-		return 0;
-}
-
 static void calc_mode_timings(int xres, int yres, int refresh,
 			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct fb_videomode *mode)
 {
@@ -795,15 +860,6 @@ static void get_monspecs(unsigned char *
 	}
 }
 
-static int edid_is_timing_block(unsigned char *block)
-{
-	if ((block[0] != 0x00) || (block[1] != 0x00) ||
-	&nbsp;&nbsp;&nbsp; (block[2] != 0x00) || (block[4] != 0x00))
-		return 1;
-	else
-		return 0;
-}
-
 int fb_parse_edid(unsigned char *edid, struct fb_var_screeninfo *var)
 {
 	int i;

</PRE>
</BODY>
</HTML>

--=-T8ULzMjVhreFyn2N3t7Q--



--===============1049773165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1049773165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1049773165==--
