From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: [PATCH 3/5] pxafb: allow insertion of delay to
	the smart panel command sequence
Date: Thu, 11 Dec 2008 17:48:17 +0800
Message-ID: <f17812d70812110148y5dbd75e1j24341d561324d213@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <eric.y.miao@gmail.com>) id 1LAi9c-0001SG-Uh
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 11 Dec 2008 09:48:20 +0000
Received: from rv-out-0708.google.com ([209.85.198.249])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LAi9a-0007FG-Tw for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 11 Dec 2008 09:48:20 +0000
Received: by rv-out-0708.google.com with SMTP id f25so796567rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 11 Dec 2008 01:48:17 -0800 (PST)
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net

Some smart panel requires a delay between command sequences, while PXA
LCD controller didn't provide such one, let's emulate this by software.

A software delay marker can be inserted into the command sequence, once
pxafb_smart_queue() detects this, it flushes the previous commands and
delay for a specified number of milliseconds.

Signed-off-by: Eric Miao <eric.miao@marvell.com>
---
 arch/arm/mach-pxa/include/mach/regs-lcd.h |    7 +++++++
 drivers/video/pxafb.c                     |   13 ++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/regs-lcd.h
b/arch/arm/mach-pxa/include/mach/regs-lcd.h
index c689c4e..f817878 100644
--- a/arch/arm/mach-pxa/include/mach/regs-lcd.h
+++ b/arch/arm/mach-pxa/include/mach/regs-lcd.h
@@ -177,4 +177,11 @@

 #define SMART_CMD(x)	(SMART_CMD_WRITE_COMMAND | ((x) & 0xff))
 #define SMART_DAT(x)	(SMART_CMD_WRITE_DATA | ((x) & 0xff))
+
+/* SMART_DELAY() is introduced for software controlled delay primitive which
+ * can be inserted between command sequences, unused command 0x6 is used here
+ * and delay ranges from 0ms ~ 255ms
+ */
+#define SMART_CMD_DELAY		(0x6 << 9)
+#define SMART_DELAY(ms)		(SMART_CMD_DELAY | ((ms) & 0xff))
 #endif /* __ASM_ARCH_REGS_LCD_H */
diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index c082547..15177ef 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -723,12 +723,19 @@ int pxafb_smart_queue(struct fb_info *info,
uint16_t *cmds, int n_cmds)
 	int i;
 	struct pxafb_info *fbi = container_of(info, struct pxafb_info, fb);

-	/* leave 2 commands for INTERRUPT and WAIT_FOR_SYNC */
-	for (i = 0; i < n_cmds; i++) {
+	for (i = 0; i < n_cmds; i++, cmds++) {
+		/* if it is a software delay, flush and delay */
+		if ((*cmds & 0xff00) == SMART_CMD_DELAY) {
+			pxafb_smart_flush(info);
+			mdelay(*cmds & 0xff);
+			continue;
+		}
+
+		/* leave 2 commands for INTERRUPT and WAIT_FOR_SYNC */
 		if (fbi->n_smart_cmds == CMD_BUFF_SIZE - 8)
 			pxafb_smart_flush(info);

-		fbi->smart_cmds[fbi->n_smart_cmds++] = *cmds++;
+		fbi->smart_cmds[fbi->n_smart_cmds++] = *cmds;
 	}

 	return 0;
-- 
1.6.0.4

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
