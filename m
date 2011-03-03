From: Stephen Hemminger <shemminger@vyatta.com>
Date: Thu, 03 Mar 2011 17:59:01 +0000
Subject: [PATCH] video via: fix iomem access
Message-Id: <20110303095901.2a283be0@nehalam>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

This driver is not respecting the iomem memory space restrictions
and does direct access. This works on x86 but is non-portable and
should not be done.  Converted memcpy() of 2 to readw.
Last post increment of romptr was unnecessary since pointer never
used after that.

Found by sparse, compile tested only.

Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>

---
 drivers/video/via/lcd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/video/via/lcd.c	2011-03-03 09:09:10.552604209 -0800
+++ b/drivers/video/via/lcd.c	2011-03-03 09:56:12.144398571 -0800
@@ -1064,34 +1064,33 @@ static struct display_timing lcd_centeri
 
 bool viafb_lcd_get_mobile_state(bool *mobile)
 {
-	unsigned char *romptr, *tableptr;
+	unsigned char __iomem *romptr, *tableptr, *biosptr;
 	u8 core_base;
-	unsigned char *biosptr;
 	/* Rom address */
-	u32 romaddr = 0x000C0000;
-	u16 start_pattern = 0;
+	const u32 romaddr = 0x000C0000;
+	u16 start_pattern;
 
 	biosptr = ioremap(romaddr, 0x10000);
+	start_pattern = readw(biosptr);
 
-	memcpy(&start_pattern, biosptr, 2);
 	/* Compare pattern */
 	if (start_pattern = 0xAA55) {
 		/* Get the start of Table */
 		/* 0x1B means BIOS offset position */
 		romptr = biosptr + 0x1B;
-		tableptr = biosptr + *((u16 *) romptr);
+		tableptr = biosptr + readw(romptr);
 
 		/* Get the start of biosver structure */
 		/* 18 means BIOS version position. */
 		romptr = tableptr + 18;
-		romptr = biosptr + *((u16 *) romptr);
+		romptr = biosptr + readw(romptr);
 
 		/* The offset should be 44, but the
 		   actual image is less three char. */
 		/* pRom += 44; */
 		romptr += 41;
 
-		core_base = *romptr++;
+		core_base = readb(romptr);
 
 		if (core_base & 0x8)
 			*mobile = false;
