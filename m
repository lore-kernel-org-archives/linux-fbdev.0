From: Jim Hague <jim.hague@acm.org>
Subject: [PATCH 2/4] pm2fb: save/restore memory config
Date: Tue, 7 Dec 2004 11:49:53 +0000
Message-ID: <20041207114953.4bff63bd@hagrid.bear-cave.org.uk>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cbdr7-00030m-AJ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Dec 2004 03:50:09 -0800
Received: from cpc1-oxfd2-6-0-cust43.oxfd.cable.ntl.com ([81.103.191.43] helo=fluffy.bear-cave.org.uk)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1Cbdqy-00010C-FI
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Dec 2004 03:50:08 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, Antonino Daplas <adaplas@pol.net>


- From 2.4 driver: Save memory config registers at init and restore after card
  reset. Reset card on mode change.

Signed-off-by: Jim Hague <jim.hague@acm.org>

=== a/drivers/video/pm2fb.c
==================================================================
--- a/drivers/video/pm2fb.c  (revision 105)
+++ b/drivers/video/pm2fb.c  (revision 106)
@@ -64,16 +64,6 @@
 #endif
 
 /*
- * The 2.4 driver calls reset_card() at init time, where it also sets the
- * initial mode. I don't think the driver should touch the chip until
- * the console sets a video mode. So I was calling this at the start
- * of setting a mode. However, certainly on 1280x1024 depth 16 on my
- * PCI Graphics Blaster Exxtreme this causes the display to smear
- * slightly.  I don't know why. Guesses to jim.hague@acm.org.
- */
-#undef RESET_CARD_ON_MODE_SET
-
-/*
  * Driver data 
  */
 static char *mode __initdata = NULL;
@@ -102,6 +92,9 @@
 	unsigned char	__iomem *v_regs;/* virtual address of p_regs */
 	u32 	   	memclock;	/* memclock */
 	u32		video;		/* video flags before blanking */
+	u32		mem_config;	/* MemConfig reg at probe */
+	u32		mem_control;	/* MemControl reg at probe */
+	u32		boot_address;	/* BootAddress reg at probe */
 };
 
 /*
@@ -351,7 +344,6 @@
 	}
 }
 
-#ifdef RESET_CARD_ON_MODE_SET
 static void reset_card(struct pm2fb_par* p)
 {
 	if (p->type == PM2_TYPE_PERMEDIA2V)
@@ -366,8 +358,14 @@
 	pm2_WR(p, PM2R_FIFO_DISCON, 1);
 	mb();
 #endif
+
+	/* Restore stashed memory config information from probe */
+	WAIT_FIFO(p, 3);
+	pm2_WR(p, PM2R_MEM_CONTROL, p->mem_control);
+	pm2_WR(p, PM2R_BOOT_ADDRESS, p->boot_address);
+	wmb();
+	pm2_WR(p, PM2R_MEM_CONFIG, p->mem_config);
 }
-#endif
 
 static void reset_config(struct pm2fb_par* p)
 {
@@ -463,6 +461,28 @@
 	pm2_WR(p, PM2R_RD_PALETTE_DATA, b);
 }
 
+static void set_memclock(struct pm2fb_par* par, u32 clk)
+{
+	int i;
+	unsigned char m, n, p;
+
+	pm2_mnp(clk, &m, &n, &p);
+	WAIT_FIFO(par, 10);
+	pm2_RDAC_WR(par, PM2I_RD_MEMORY_CLOCK_3, 6);
+	wmb();
+	pm2_RDAC_WR(par, PM2I_RD_MEMORY_CLOCK_1, m);
+	pm2_RDAC_WR(par, PM2I_RD_MEMORY_CLOCK_2, n);
+	wmb();
+	pm2_RDAC_WR(par, PM2I_RD_MEMORY_CLOCK_3, 8|p);
+	wmb();
+	pm2_RDAC_RD(par, PM2I_RD_MEMORY_CLOCK_STATUS);
+	rmb();
+	for (i = 256;
+	     i && !(pm2_RD(par, PM2R_RD_INDEXED_DATA) & PM2F_PLL_LOCKED);
+	     i--)
+		;
+}
+
 static void set_pixclock(struct pm2fb_par* par, u32 clk)
 {
 	int i;
@@ -664,11 +684,11 @@
 	u32 xres;
 	int data64;
 
-#ifdef RESET_CARD_ON_MODE_SET
 	reset_card(par);
-#endif
 	reset_config(par);
 	clear_palette(par);
+	if ( par->memclock )
+		set_memclock(par, par->memclock);
     
 	width = (info->var.xres_virtual + 7) & ~7;
 	height = info->var.yres_virtual;
@@ -1035,7 +1055,6 @@
 	struct pm2fb_par *default_par;
 	struct fb_info *info;
 	int size, err;
-	u32 pci_mem_config;
 	int err_retval = -ENXIO;
 
 	err = pci_enable_device(pdev);
@@ -1087,9 +1106,16 @@
 		goto err_exit_neither;
 	}
 
+	/* Stash away memory register info for use when we reset the board */
+	default_par->mem_control = pm2_RD(default_par, PM2R_MEM_CONTROL);
+	default_par->boot_address = pm2_RD(default_par, PM2R_BOOT_ADDRESS);
+	default_par->mem_config = pm2_RD(default_par, PM2R_MEM_CONFIG);
+	DPRINTK("MemControl 0x%x BootAddress 0x%x MemConfig 0x%x\n",
+		default_par->mem_control, default_par->boot_address,
+		default_par->mem_config);
+
 	/* Now work out how big lfb is going to be. */
-	pci_mem_config = RD32(default_par->v_regs, PM2R_MEM_CONFIG);
-	switch(pci_mem_config & PM2F_MEM_CONFIG_RAM_MASK) {
+	switch(default_par->mem_config & PM2F_MEM_CONFIG_RAM_MASK) {
 	case PM2F_MEM_BANKS_1:
 		default_par->fb_size=0x200000;
 		break;


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
