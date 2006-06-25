From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: radeonfb: DDC read wrong?
Date: Sun, 25 Jun 2006 08:00:30 +0800
Message-ID: <449DD21E.9070906@gmail.com>
References: <20060620140152.GB5414@polar.elf12.net>	<449D2C02.8010101@gmail.com>
	<20060624174731.GA6091@polar.elf12.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FuI3K-0006hx-Qy for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 24 Jun 2006 17:00:38 -0700
Received: from py-out-1112.google.com ([64.233.166.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FuI3J-000533-Gz
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 24 Jun 2006 17:00:38 -0700
Received: by py-out-1112.google.com with SMTP id d42so1142472pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 24 Jun 2006 17:00:36 -0700 (PDT)
In-Reply-To: <20060624174731.GA6091@polar.elf12.net>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Robert Siemer <Robert.Siemer@backsla.sh>

Robert Siemer wrote:
> On Sat, Jun 24, 2006 at 08:11:46PM +0800, Antonino A. Daplas wrote:
>> Robert Siemer wrote:

Disregard the previous patch, I forgot to adjust the checksum.
Try this instead...

Tony

diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index fb9ed4c..42865b6 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -49,8 +49,9 @@ #else
 #define DPRINTK(fmt, args...)
 #endif
 
-#define FBMON_FIX_HEADER 1
-#define FBMON_FIX_INPUT  2
+#define FBMON_FIX_HEADER   1
+#define FBMON_FIX_INPUT    2
+#define FBMON_FIX_DETAILED 3
 
 #ifdef CONFIG_FB_MODE_HELPERS
 struct broken_edid {
@@ -72,6 +73,12 @@ static struct broken_edid brokendb[] = {
 		.model        = 0x5a44,
 		.fix          = FBMON_FIX_INPUT,
 	},
+	/* Eizo (202) */
+	{
+		.manufacturer = "EIZ",
+		.model        = 0x0202,
+		.fix          = FBMON_FIX_DETAILED,
+	},
 };
 
 static const unsigned char edid_v1_header[] = { 0x00, 0xff, 0xff, 0xff,
@@ -127,6 +134,18 @@ static int check_edid(unsigned char *edi
 		if (b[4] & 0x01 && b[0] & 0x80)
 			ret = fix;
 		break;
+	case FBMON_FIX_DETAILED:
+		b = edid + DETAILED_TIMING_DESCRIPTIONS_START;
+
+		for (i = 0; i < 4; i++, b+=DETAILED_TIMING_DESCRIPTION_SIZE) {
+			if (!(b[0] == 0 && b[1] == 0 &&
+			      b[2] == 0 && b[4] == 0)) {
+				ret = fix;
+				break;
+			}
+		}
+
+		break;
 	}
 
 	return ret;
@@ -134,7 +153,8 @@ static int check_edid(unsigned char *edi
 
 static void fix_edid(unsigned char *edid, int fix)
 {
-	unsigned char *b;
+	unsigned char *b, csum = 0;
+	int i;
 
 	switch (fix) {
 	case FBMON_FIX_HEADER:
@@ -146,8 +166,29 @@ static void fix_edid(unsigned char *edid
 		b = edid + EDID_STRUCT_DISPLAY;
 		b[0] &= ~0x80;
 		edid[127] += 0x80;
+		break;
+	case FBMON_FIX_DETAILED:
+		printk("fbmon: trying to fix detailed description blocks\n");
+		b = edid + DETAILED_TIMING_DESCRIPTIONS_START;
+
+		/* Use 0xf0 which is currently unused for tagging */
+		for (i = 0; i < 4; i++, b+=DETAILED_TIMING_DESCRIPTION_SIZE) {
+			if (!(b[0] == 0 && b[1] == 0 &&
+			      b[2] == 0 && b[4] == 0)) {
+				b[3] = 0xf0;
+				b[0] = 	b[1] = b[2] = b[4] = 0;
+			}
+		}
+
+		for (i = 0; i < EDID_LENGTH - 1; i++)
+			csum += edid[i];
+
+		csum = 256 - csum;
+		edid[EDID_LENGTH - 1] = csum;
+
 	}
-}
+}
+
 
 static int edid_checksum(unsigned char *edid)
 {

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
