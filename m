From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 17/20] pm2fb: removal of pm2fb_par fields
Date: Sat, 05 May 2007 23:04:38 +0800
Message-ID: <463C9D06.2020207@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HkMjC-0003Lf-5G for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 09:03:22 -0700
Received: from py-out-1112.google.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HkMEU-0008EN-69
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 08:31:39 -0700
Received: by py-out-1112.google.com with SMTP id a29so906538pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 05 May 2007 08:31:38 -0700 (PDT)
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

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch removes two redudant fields in the pm2fb_par
structure.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/pm2fb.c |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
index 5693da5..7f4c753 100644
--- a/drivers/video/pm2fb.c
+++ b/drivers/video/pm2fb.c
@@ -81,8 +81,6 @@ static int lowvsync;
 struct pm2fb_par
 {
 	pm2type_t	type;		/* Board type */
-	u32		fb_size;	/* framebuffer memory size */
-	unsigned char	__iomem *v_fb;  /* virtual address of frame buffer */
 	unsigned char	__iomem *v_regs;/* virtual address of p_regs */
 	u32 	   	memclock;	/* memclock */
 	u32		video;		/* video flags before blanking */
@@ -1293,20 +1291,19 @@ #endif
 	/* Now work out how big lfb is going to be. */
 	switch(default_par->mem_config & PM2F_MEM_CONFIG_RAM_MASK) {
 	case PM2F_MEM_BANKS_1:
-		default_par->fb_size=0x200000;
+		pm2fb_fix.smem_len=0x200000;
 		break;
 	case PM2F_MEM_BANKS_2:
-		default_par->fb_size=0x400000;
+		pm2fb_fix.smem_len=0x400000;
 		break;
 	case PM2F_MEM_BANKS_3:
-		default_par->fb_size=0x600000;
+		pm2fb_fix.smem_len=0x600000;
 		break;
 	case PM2F_MEM_BANKS_4:
-		default_par->fb_size=0x800000;
+		pm2fb_fix.smem_len=0x800000;
 		break;
 	}
 	pm2fb_fix.smem_start = pci_resource_start(pdev, 1);
-	pm2fb_fix.smem_len = default_par->fb_size;
 
 	/* Linear frame buffer - request region and map it. */
 	if ( !request_mem_region(pm2fb_fix.smem_start, pm2fb_fix.smem_len,
@@ -1314,9 +1311,9 @@ #endif
 		printk(KERN_WARNING "pm2fb: Can't reserve smem.\n");
 		goto err_exit_mmio;
 	}
-	info->screen_base = default_par->v_fb =
+	info->screen_base =
 		ioremap_nocache(pm2fb_fix.smem_start, pm2fb_fix.smem_len);
-	if ( !default_par->v_fb ) {
+	if ( !info->screen_base ) {
 		printk(KERN_WARNING "pm2fb: Can't ioremap smem area.\n");
 		release_mem_region(pm2fb_fix.smem_start, pm2fb_fix.smem_len);
 		goto err_exit_mmio;
@@ -1344,7 +1341,7 @@ #endif
 		goto err_exit_both;
 
 	printk(KERN_INFO "fb%d: %s frame buffer device, memory = %dK.\n",
-	       info->node, info->fix.id, default_par->fb_size / 1024);
+	       info->node, info->fix.id, pm2fb_fix.smem_len / 1024);
 
 	/*
 	 * Our driver data


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
