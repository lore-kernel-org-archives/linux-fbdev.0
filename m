From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: radeonfb: DDC read wrong?
Date: Sun, 25 Jun 2006 07:27:08 +0800
Message-ID: <449DCA4C.7060400@gmail.com>
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
	id 1FuHX2-00044I-BB for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 24 Jun 2006 16:27:16 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FuHX0-0007OU-Sv
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 24 Jun 2006 16:27:16 -0700
Received: by py-out-1112.google.com with SMTP id d42so1138021pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 24 Jun 2006 16:27:13 -0700 (PDT)
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
>>> Hello everybody!
>>>
>>> Any comments?
>> Can you change #undef DEBUG to #define DEBUG in drivers/video/fbmon.c
>> then post your dmesg?
>>
>> If your monitor's EDID block is faulty, we can add it to our
>> monitor database for fixups.
> 
> Have you read this message from me?
> http://marc.theaimsgroup.com/?l=linux-fbdev-devel&m=115096319623635&w=2

Okay, now I see it.

> 
> The EDID block has a correct checksum as "get-edid | parse-edid" is
> saying...
> 
> The monitor is a 17", with frequencies H: 30 - 86 kHz, V: 55 - 160 Hz. I
> recommand it with 1024x768@100
> 

BTW, I'm attaching a patch that does basic fix-ups. It just marks the
invalid detailed timings descriptor blocks to "unknown".  Post your
dmesg again, and if it works you should see something like:

fbmon: The EDID block of blah-blah is known to be broken
fbmon: Trying to fix blah-blah

As mentioned, this is a basic fix. We can be more fancy with the fix-ups
but I will need the specifications of your monitor.

Hsync and Vsync ranges, PixelClock
A working and preferred modeline to replace the detailed timing:
	 xvidtune would help
A few supported VESA compatible modes,
etc...

Tony

diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index fb9ed4c..31ccc35 100644
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
@@ -127,6 +134,17 @@ static int check_edid(unsigned char *edi
 		if (b[4] & 0x01 && b[0] & 0x80)
 			ret = fix;
 		break;
+	case FBMON_FIX_DETAILED:
+		b = edid + DETAILED_TIMING_DESCRIPTIONS_START;
+
+		for (i = 0; i < 4; i++, b+=DETAILED_TIMING_DESCRIPTION_SIZE) {
+			if (!(b[0] == 0 && b[1] == 0 && b[2] == 0)) {
+				ret = fix;
+				break;
+			}
+		}
+
+		break;
 	}
 
 	return ret;
@@ -135,6 +153,7 @@ static int check_edid(unsigned char *edi
 static void fix_edid(unsigned char *edid, int fix)
 {
 	unsigned char *b;
+	int i;
 
 	switch (fix) {
 	case FBMON_FIX_HEADER:
@@ -146,8 +165,21 @@ static void fix_edid(unsigned char *edid
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
+			if (!(b[0] == 0 && b[1] == 0 && b[2] == 0)) {
+				b[3] = 0xf0;
+				b[0] = 	b[1] = b[2] = b[4] = 0;
+			}
+		}
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
