From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH]: frame buffer driver for 2700G LCD
 controller
Date: Tue, 11 Jul 2006 16:14:11 +0200
Message-ID: <44B3B233.7020908@compulab.co.il>
References: <44AD2B75.6050302@compulab.co.il> <44ADC4AE.2040903@gmail.com>
	<44B11542.7010402@compulab.co.il> <44B18F68.2080802@gmail.com>
	<44B3954D.4040302@compulab.co.il> <44B39F59.9030605@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G0I4L-00029d-T9 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Jul 2006 06:14:30 -0700
Received: from mail.linux-boards.com ([62.90.235.247])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1G0I4K-0003fA-LI
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Jul 2006 06:14:29 -0700
In-Reply-To: <44B39F59.9030605@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Antonino A. Daplas wrote:

>Mike Rapoport wrote:
>  
>
>>Antonino A. Daplas wrote:
>>    
>>
>>>Mike Rapoport wrote:
>>>      
>>>
>>>>Antonino A. Daplas wrote:
>>>>        
>>>>
>>>>>Mike Rapoport wrote:
>>>>>          
>>>>>
>>>>>>This patch adds frame buffer driver for 2700G LCD controller
>>>>>>present on
>>>>>>CompuLab CM-X270 computer module.
>>>>>>This pacth is versus current Linus git tree.
>>>>>>
>>>>>>Signed-off-by: Mike Rapoport <mike@compulab.co.il>       
>>>>>>            
>>>>>>
>Definitely much, much better. I'm attaching a clean-up patch. If you
>approve, I'll send your patch + cleanup upstream.
>
>  
>
It's Ok with me, thanks.

>Tony
>
>mbxfb: Various fixes
>
>From:  <>
>
>- Add more informative help text to Kconfig
>- Make DEBUG a Kconfig option as FB_MBX_DEBUG
>- Remove #include mbxdebug.c, this is frowned upon
>- Remove redundant casts
>- Arrange #include's alphabetically
>- Trivial whitespace changes
>
>Signed-off-by: Antonino Daplas <adaplas@pol.net>
>---
>
> drivers/video/Kconfig      |   12 +++++++++++-
> drivers/video/mbx/Makefile |    3 ++-
> drivers/video/mbx/mbxfb.c  |   24 +++++++++++-------------
> 3 files changed, 24 insertions(+), 15 deletions(-)
>
>diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
>index 0f4af08..153e23e 100644
>--- a/drivers/video/Kconfig
>+++ b/drivers/video/Kconfig
>@@ -1547,8 +1547,18 @@ config FB_MBX
> 	select FB_CFB_COPYAREA
> 	select FB_CFB_IMAGEBLIT
> 	---help---
>+	  Framebuffer driver for the Intel 2700G (Marathon) Graphics
>+	  Accelerator
> 
>-	  If unsure, say N.
>+config FB_MBX_DEBUG
>+       bool "Enable debugging info via debugfs"
>+       depends on FB_MBX && DEBUG_FS
>+       default n
>+       ---help---
>+         Enable this if you want debugging information using the debug
>+         filesystem (debugfs)
>+
>+         If unsure, say N.
> 
> config FB_W100
> 	tristate "W100 frame buffer support"
>diff --git a/drivers/video/mbx/Makefile b/drivers/video/mbx/Makefile
>index ad042f5..16c1165 100644
>--- a/drivers/video/mbx/Makefile
>+++ b/drivers/video/mbx/Makefile
>@@ -1,3 +1,4 @@
> # Makefile for the 2700G controller driver.
> 
>-obj-$(CONFIG_FB_MBX)	+= mbxfb.o
>+obj-$(CONFIG_FB_MBX)	   += mbxfb.o
>+obj-$(CONFIG_FB_MBX_DEBUG) += mbxfbdebugfs.o
>diff --git a/drivers/video/mbx/mbxfb.c b/drivers/video/mbx/mbxfb.c
>index 7834586..a5836b5 100644
>--- a/drivers/video/mbx/mbxfb.c
>+++ b/drivers/video/mbx/mbxfb.c
>@@ -14,22 +14,21 @@
>  *
>  */
> 
>-#include <linux/module.h>
>-#include <linux/fb.h>
> #include <linux/delay.h>
>+#include <linux/fb.h>
> #include <linux/init.h>
>+#include <linux/module.h>
> #include <linux/platform_device.h>
> 
>-#include <video/mbxfb.h>
>-
> #include <asm/io.h>
> 
>-#undef DEBUG
>+#include <video/mbxfb.h>
> 
>-static unsigned long virt_base_2700;
> #include "regs.h"
> #include "reg_bits.h"
> 
>+static unsigned long virt_base_2700;
>+
> #define MIN_XRES	16
> #define MIN_YRES	16
> #define MAX_XRES	2048
>@@ -59,7 +58,7 @@ struct mbxfb_info {
> 	int (*platform_probe) (struct fb_info * fb);
> 	int (*platform_remove) (struct fb_info * fb);
> 
>-#if defined(CONFIG_DEBUG_FS) && defined(DEBUG)
>+#ifdef CONFIG_FB_MBX_DEBUG
> 	void *debugfs_data;
> #endif
> 
>@@ -145,7 +144,8 @@ static int mbxfb_setcolreg(u_int regno, 
> 	if (regno < MAX_PALETTES) {
> 		u32 *pal = info->pseudo_palette;
> 
>-		val = (red & 0xf800) | ((green & 0xfc00) >> 5) | ((blue & 0xf800) >> 11);
>+		val = (red & 0xf800) | ((green & 0xfc00) >> 5) |
>+			((blue & 0xf800) >> 11);
> 		pal[regno] = val;
> 		ret = 0;
> 	}
>@@ -477,7 +477,7 @@ static int mbxfb_suspend(struct platform
> 
> static int mbxfb_resume(struct platform_device *dev)
> {
>-	struct fb_info *fbi = (struct fb_info *)platform_get_drvdata(dev);
>+	struct fb_info *fbi = platform_get_drvdata(dev);
> 
> 	enable_clocks(fbi);
> /* 	setup_graphics(fbi); */
>@@ -492,9 +492,7 @@ #define mbxfb_resume	NULL
> #endif
> 
> /* debugfs entries */
>-#if defined(CONFIG_DEBUG_FS) && defined(DEBUG)
>-#include "mbxdebugfs.c"
>-#else
>+#ifndef CONFIG_FB_MBX_DEBUG
> #define mbxfb_debugfs_init(x)	do {} while(0)
> #define mbxfb_debugfs_remove(x)	do {} while(0)
> #endif
>@@ -632,7 +630,7 @@ err1:
> 
> static int __devexit mbxfb_remove(struct platform_device *dev)
> {
>-	struct fb_info *fbi = (struct fb_info *)platform_get_drvdata(dev);
>+	struct fb_info *fbi = platform_get_drvdata(dev);
> 
> 	writel(SYSRST_RST, SYSRST);
> 	udelay(1000);
>
>
>
>  
>


-- 
Sincerely yours,
Mike Rapoport



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
