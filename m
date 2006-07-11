From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH]: frame buffer driver for 2700G LCD
 controller
Date: Tue, 11 Jul 2006 20:53:45 +0800
Message-ID: <44B39F59.9030605@gmail.com>
References: <44AD2B75.6050302@compulab.co.il> <44ADC4AE.2040903@gmail.com>
	<44B11542.7010402@compulab.co.il> <44B18F68.2080802@gmail.com>
	<44B3954D.4040302@compulab.co.il>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G0HkR-0000FA-5E for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Jul 2006 05:53:55 -0700
Received: from py-out-1112.google.com ([64.233.166.179])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G0HkQ-0007dU-NK
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Jul 2006 05:53:55 -0700
Received: by py-out-1112.google.com with SMTP id c31so4299826pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 11 Jul 2006 05:53:50 -0700 (PDT)
In-Reply-To: <44B3954D.4040302@compulab.co.il>
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
To: Mike Rapoport <mike@compulab.co.il>
Cc: linux-fbdev-devel@lists.sourceforge.net

Mike Rapoport wrote:
> Antonino A. Daplas wrote:
> 
>> Mike Rapoport wrote:
>>  
>>
>>> Antonino A. Daplas wrote:
>>>
>>>   
>>>> Mike Rapoport wrote:
>>>>
>>>>
>>>>     
>>>>> This patch adds frame buffer driver for 2700G LCD controller
>>>>> present on
>>>>> CompuLab CM-X270 computer module.
>>>>> This pacth is versus current Linus git tree.
>>>>>
>>>>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>       
>> It's because you don't have an info->pseudo_palette. And if you
>> accidentally
>> load the framebuffer console, your kernel will just crash because the
>> drawing functions (cfb_{fillrect,imageblit}) unconditionally refers to
>> that
>> array.
>>
>> So you have to do either one:
>>
>> 1. Create a properly filled up info->pseudo_palette; or
>>  
>>
> I think I've succeded to make it. At least I can see tux logo and getty
> output at startup.
> 
>> BTW, you will need to use generic accessors (readb|w|l, writeb|w|l or
>> __raw_readb|w|l, __raw_writeb|w|l, etc). This will entail a lot of
>> changes.
>> Otherwise, this driver won't get past Andrew Morton and Rusty.
>>
>> See include/asm/io.h.
>>  
>>
> Done.

Definitely much, much better. I'm attaching a clean-up patch. If you
approve, I'll send your patch + cleanup upstream.

Tony

mbxfb: Various fixes

From:  <>

- Add more informative help text to Kconfig
- Make DEBUG a Kconfig option as FB_MBX_DEBUG
- Remove #include mbxdebug.c, this is frowned upon
- Remove redundant casts
- Arrange #include's alphabetically
- Trivial whitespace changes

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/Kconfig      |   12 +++++++++++-
 drivers/video/mbx/Makefile |    3 ++-
 drivers/video/mbx/mbxfb.c  |   24 +++++++++++-------------
 3 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 0f4af08..153e23e 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1547,8 +1547,18 @@ config FB_MBX
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	---help---
+	  Framebuffer driver for the Intel 2700G (Marathon) Graphics
+	  Accelerator
 
-	  If unsure, say N.
+config FB_MBX_DEBUG
+       bool "Enable debugging info via debugfs"
+       depends on FB_MBX && DEBUG_FS
+       default n
+       ---help---
+         Enable this if you want debugging information using the debug
+         filesystem (debugfs)
+
+         If unsure, say N.
 
 config FB_W100
 	tristate "W100 frame buffer support"
diff --git a/drivers/video/mbx/Makefile b/drivers/video/mbx/Makefile
index ad042f5..16c1165 100644
--- a/drivers/video/mbx/Makefile
+++ b/drivers/video/mbx/Makefile
@@ -1,3 +1,4 @@
 # Makefile for the 2700G controller driver.
 
-obj-$(CONFIG_FB_MBX)	+= mbxfb.o
+obj-$(CONFIG_FB_MBX)	   += mbxfb.o
+obj-$(CONFIG_FB_MBX_DEBUG) += mbxfbdebugfs.o
diff --git a/drivers/video/mbx/mbxfb.c b/drivers/video/mbx/mbxfb.c
index 7834586..a5836b5 100644
--- a/drivers/video/mbx/mbxfb.c
+++ b/drivers/video/mbx/mbxfb.c
@@ -14,22 +14,21 @@
  *
  */
 
-#include <linux/module.h>
-#include <linux/fb.h>
 #include <linux/delay.h>
+#include <linux/fb.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 
-#include <video/mbxfb.h>
-
 #include <asm/io.h>
 
-#undef DEBUG
+#include <video/mbxfb.h>
 
-static unsigned long virt_base_2700;
 #include "regs.h"
 #include "reg_bits.h"
 
+static unsigned long virt_base_2700;
+
 #define MIN_XRES	16
 #define MIN_YRES	16
 #define MAX_XRES	2048
@@ -59,7 +58,7 @@ struct mbxfb_info {
 	int (*platform_probe) (struct fb_info * fb);
 	int (*platform_remove) (struct fb_info * fb);
 
-#if defined(CONFIG_DEBUG_FS) && defined(DEBUG)
+#ifdef CONFIG_FB_MBX_DEBUG
 	void *debugfs_data;
 #endif
 
@@ -145,7 +144,8 @@ static int mbxfb_setcolreg(u_int regno, 
 	if (regno < MAX_PALETTES) {
 		u32 *pal = info->pseudo_palette;
 
-		val = (red & 0xf800) | ((green & 0xfc00) >> 5) | ((blue & 0xf800) >> 11);
+		val = (red & 0xf800) | ((green & 0xfc00) >> 5) |
+			((blue & 0xf800) >> 11);
 		pal[regno] = val;
 		ret = 0;
 	}
@@ -477,7 +477,7 @@ static int mbxfb_suspend(struct platform
 
 static int mbxfb_resume(struct platform_device *dev)
 {
-	struct fb_info *fbi = (struct fb_info *)platform_get_drvdata(dev);
+	struct fb_info *fbi = platform_get_drvdata(dev);
 
 	enable_clocks(fbi);
 /* 	setup_graphics(fbi); */
@@ -492,9 +492,7 @@ #define mbxfb_resume	NULL
 #endif
 
 /* debugfs entries */
-#if defined(CONFIG_DEBUG_FS) && defined(DEBUG)
-#include "mbxdebugfs.c"
-#else
+#ifndef CONFIG_FB_MBX_DEBUG
 #define mbxfb_debugfs_init(x)	do {} while(0)
 #define mbxfb_debugfs_remove(x)	do {} while(0)
 #endif
@@ -632,7 +630,7 @@ err1:
 
 static int __devexit mbxfb_remove(struct platform_device *dev)
 {
-	struct fb_info *fbi = (struct fb_info *)platform_get_drvdata(dev);
+	struct fb_info *fbi = platform_get_drvdata(dev);
 
 	writel(SYSRST_RST, SYSRST);
 	udelay(1000);


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
